# frozen_string_literal: true

class Question < ApplicationRecord
  default_scope { order(:position) }

  belongs_to :questionnaire
  belongs_to :answer_component, foreign_key: :answer_component_type, primary_key: :type
  belongs_to :answer_gateway, foreign_key: :answer_gateway_rule, primary_key: :rule, optional: true

  def to_profile_value(answer)
    case true # rubocop:disable Lint/LiteralAsCondition
    when answer_component.date?
      answer_gateway.eval_date(answer['value'])
    when answer_component.yes_or_no?
      answer_gateway.eval_yes_or_no(answer['value'])
    when answer_component.overtime?
      answer_gateway.eval_overtime(answer['values'].values.map(&:to_i))
    else
      raise NotImplementedError
    end
  end
end
