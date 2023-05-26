# frozen_string_literal: true

class CreateApprovals < ActiveRecord::Migration[7.0]
  def change
    create_table :approvals do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :survey, null: false, foreign_key: false
      t.date :created_on, null: false
    end

    add_index :approvals, %i[user_id survey_id], unique: true
  end
end
