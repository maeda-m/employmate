# frozen_string_literal: true

class Survey < ActiveYaml::Base
  include ActiveHash::Associations

  has_many :questionnaires
  has_many :tasks

  scope :profiles, lambda {
    where(type: 'initial_profile')
  }

  scope :approvals, lambda {
    where(type: 'approved_release_form')
  }

  scope :issuances, lambda {
    where(type: 'issued_employment_insurance_eligibility_card')
  }

  scope :tasks, lambda {
    # NOTE: ActiveYaml のため approvals.or(Survey.issuances) は使用できない
    where(type: %w[approved_release_form issued_employment_insurance_eligibility_card])
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

  def approved_release_form?
    id == Survey.approved_release_form.id
  end

  def issued_employment_insurance_eligibility_card?
    id == Survey.issued_employment_insurance_eligibility_card.id
  end

  def questionnaires_with_questions(position:)
    questionnaires.with_questions(position)
  end

  def questions_by(position:)
    questionnaires_with_questions(position:).map(&:questions).flatten
  end

  def all_questions
    questions_by(position: Range.new(nil, nil))
  end

  def next_question(current_question, answer_values)
    position = Range.new(current_question.position + 1, nil)
    questions = questions_by(position:)

    questions.find { |question| question.answer_condition_fulfilled?(answer_values) }
  end

  def prev_question(current_question, answer_values)
    position = Range.new(nil, current_question.position - 1)
    questions = questions_by(position:)

    answer_values = available_question_answer_values(answer_values:)
    questions.reverse.find { |question| question.answer_condition_fulfilled?(answer_values) }
  end

  def answer_values_to_profile_attributes(answer_values:)
    answer_values = available_question_answer_values(answer_values:)
    questions_with_gateway = all_questions.select(&:answer_gateway_rule).group_by(&:answer_gateway)

    results = {}
    questions_with_gateway.each do |gateway, questions|
      results[gateway.rule] = gateway.cast_value(answer_values, questions)
    end

    results
  end

  private

  def available_question_answer_values(answer_values:)
    available_question_ids = []
    current_question = all_questions.first
    all_questions.size.times do
      available_question_ids << current_question.id
      current_question = next_question(current_question, answer_values)

      break if current_question.nil?
    end

    answer_values.slice(available_question_ids)
  end
end
