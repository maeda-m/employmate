# frozen_string_literal: true

module AnswerParameter
  extend ActiveSupport::Concern

  class AnswerCollection
    def initialize(answers)
      @answers = answers.to_h.map do |question_id, answer|
        question_id = question_id.to_i
        AnswerValue.new(question_id, answer)
      end
    end

    def [](question_id)
      @answers.find { |answer| answer.question_id == question_id }
    end
  end

  class AnswerValue
    attr_reader :question_id

    def initialize(question_id, answer)
      @question_id = question_id
      @answer = answer
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
    survey = current_question.questionnaire.survey
    questions = survey.questionnaires_with_questions(position)
    question_ids = questions.map { |question| question.id.to_s }

    AnswerCollection.new(answers_params.slice(*question_ids))
  end
end
