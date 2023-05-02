# frozen_string_literal: true

class AddAnswerGatewayRuleToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :answer_gateway_rule, :string
  end
end
