# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :questionnaire
  belongs_to :answer_component, foreign_key: :answer_component_type, primary_key: :type
  belongs_to :answer_gateway, foreign_key: :answer_gateway_rule, primary_key: :rule, optional: true

  has_one :answer_condition, dependent: :destroy

  scope :default_order, lambda {
    order(:position)
  }

  def answer_condition_fulfilled?(answer_values)
    return true if answer_condition.nil?

    answer_condition.fulfilled?(answer_values)
  end

  def to_profile_value(answer)
    if answer_component.overtime?
      answer_gateway.eval_overtime(answer.to_a.map(&:to_i))
    else
      answer_gateway.send("eval_#{answer_component.type}", answer.to_s)
    end
  end
end
