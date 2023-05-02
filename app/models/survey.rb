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

  def next_question(question)
    navigate_question(question, 1)
  end

  def prev_question(question)
    navigate_question(question, -1)
  end

  private

  def navigate_question(question, direction)
    position = question.position + direction
    questionnaire = questionnaires.eager_load(:questions)
                                  .merge(Question.where(position:))
                                  .first

    return nil unless questionnaire

    questionnaire.questions.first
  end
end
