# frozen_string_literal: true

class Question < ApplicationRecord
  delegate :survey_id, to: :questionnaire

  belongs_to :questionnaire
  belongs_to :answer_component, foreign_key: :answer_component_type, primary_key: :type
end
