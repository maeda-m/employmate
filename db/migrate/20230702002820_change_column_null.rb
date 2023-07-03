# frozen_string_literal: true

class ChangeColumnNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :answer_conditions, :answered, false
    change_column_null :answer_conditions, :equal, false

    change_column_null :issuances, :done, false

    change_column_null :profiles, :recommended_to_extension_of_benefit_receivable_period, false
    change_column_null :profiles, :recommended_to_public_vocational_training, false
    change_column_null :profiles, :unemployed_with_special_eligible, false
    change_column_null :profiles, :unemployed_with_special_reason, false

    change_column_null :questionnaires, :title, false

    change_column_null :questions, :body, false

    change_column_null :tasks, :title, false
    change_column_null :tasks, :done, false
  end
end
