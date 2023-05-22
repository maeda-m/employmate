# frozen_string_literal: true

class Survey < ActiveYaml::Base
  include ActiveHash::Associations

  has_many :questionnaires

  scope :profiles, lambda {
    where(type: 'initial_profile')
  }

  scope :approvals, lambda {
    where(type: 'approved_release_form')
  }

  scope :issuances, lambda {
    where(type: 'issued_employment_insurance_eligibility_card')
  }

  def self.initial_profile
    profiles.first
  end

  def self.approved_release_form
    approvals.first
  end

  def self.issued_employment_insurance_eligibility_card
    issuances.first
  end

  def type_of_profile?
    ActiveSupport::Deprecation.warn('TODO: 後で消す')
    type.inquiry.initial_profile?
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
