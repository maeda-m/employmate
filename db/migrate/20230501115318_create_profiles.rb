# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.belongs_to :user, null: false, foreign_key: true, index: { unique: true }
      t.date :unemployed_on
      t.boolean :recommended_to_extension_of_benefit_receivable_period, default: false
      t.boolean :recommended_to_public_vocational_training, default: false
      t.boolean :unemployed_with_special_eligible, default: false
      t.boolean :unemployed_with_special_reason, default: false
      t.date :explanitory_seminar_on_for_employment_insurance
      t.date :first_unemployment_certification_on
      t.string :week_type_for_unemployment_certification
      t.string :day_of_week_for_unemployment_certification
      t.string :reason_code_for_loss_of_employment
    end
  end
end
