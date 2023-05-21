# frozen_string_literal: true

class Survey < ActiveYaml::Base
  include ActiveHash::Associations

  has_many :questionnaires

  scope :profiles, lambda {
    where(type: 'profile').order(:id)
  }

  def type_of_profile?
    type.inquiry.profile?
  end

  def questionnaires_with_questions(position)
    questionnaires.eager_load(:questions).merge(Question.where(position:)).map(&:questions).flatten
  end

  def next_question(current_question, answer_values)
    position = current_question.position + 1
    question = questionnaires_with_questions(position).first

    return nil unless question
    return question if question.answer_condition_fulfilled?(answer_values)

    next_question(question, answer_values)
  end

  def prev_question(current_question, answer_values)
    position = Range.new(nil, current_question.position - 1)
    questions = questionnaires_with_questions(position)

    questions.reverse.find { |question| question.answer_condition_fulfilled?(answer_values) }
  end
end
