# frozen_string_literal: true

class CreateAnswerConditions < ActiveRecord::Migration[7.0]
  def change
    create_table :answer_conditions do |t|
      t.belongs_to :question, null: false, foreign_key: true, index: { unique: true }
      t.boolean :answered, default: false
      t.boolean :equal, default: false
      t.belongs_to :condition_question, null: false, foreign_key: { to_table: :questions }, index: true
      t.string :condition_answer_value
    end
  end
end
