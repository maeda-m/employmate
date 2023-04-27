# frozen_string_literal: true

class Survey < ActiveYaml::Base
  include ActiveHash::Associations

  has_many :questionnaires

  scope :profiles, lambda {
    where(survey_type: 'profile').order(:id)
  }

  def next_question(question_id)
    navigate_question(question_id, 1)
  end

  def prev_question(question_id)
    navigate_question(question_id, -1)
  end

  private

  def navigate_question(question_id, direction)
    position = Question.find(question_id).position + direction
    questionnaire = questionnaires.eager_load(:questions)
                                  .merge(Question.where(position:))
                                  .first

    return nil unless questionnaire

    questionnaire.questions.first
  end
end
