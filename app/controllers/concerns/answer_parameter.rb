# frozen_string_literal: true

module AnswerParameter
  extend ActiveSupport::Concern

  class AnswerCollection
    delegate :map, :reject, to: :@answers

    def initialize(answers)
      @origin_answers = answers.to_h
      @answers = @origin_answers.map do |question_id, answer|
        question_id = question_id.to_i
        AnswerValue.new(question_id, answer)
      end
    end

    def [](question_id)
      @answers.find { |answer| answer.question_id == question_id }
    end

    def slice(ids)
      keys = ids.map(&:to_s)
      AnswerCollection.new(@origin_answers.slice(*keys))
    end
  end

  class AnswerValue
    attr_reader :question_id

    def initialize(question_id, answer)
      @question_id = question_id
      @answer = answer
    end

    def cast_value
      question.cast_value(self)
    end

    def question
      @question ||= Question.find(question_id)
    end

    def to_s
      @answer['value']
    end

    def to_a
      @answer['values'].values
    end
  end

  private

  def answers_params
    values = Array.new(OvertimeField::Component::FIELD_COUNT, &:to_s)

    params.require(:answers)
    params.permit(answers: [:value, { values: }])[:answers]
  end

  def answer_values
    AnswerCollection.new(answers_params)
  end

  def answer_values_without_next_questions(current_question)
    position = Range.new(nil, current_question.position)
    questions = current_question.survey.questions_by(position:)

    answer_values.slice(questions.map(&:id))
  end

  def answer_values_to_event_history_date
    answer_values.reject { |answer_value| answer_value.question.answer_gateway_rule }
                 .find { |answer_value| answer_value.question.answer_component_date? }.to_s
  end
end
