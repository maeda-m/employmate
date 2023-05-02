# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :questionnaire
  belongs_to :answer_component, foreign_key: :answer_component_type, primary_key: :type
  belongs_to :answer_gateway, foreign_key: :answer_gateway_rule, primary_key: :rule, optional: true
end
