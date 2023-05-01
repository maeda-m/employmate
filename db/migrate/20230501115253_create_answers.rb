# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :survey, null: false, foreign_key: false
      t.datetime :created_at, null: false
    end

    add_index :answers, %i[user_id survey_id], unique: true
  end
end
