# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.belongs_to :questionnaire, null: false, foreign_key: true
      t.string :body
      t.string :answer_component_type, null: false
      t.boolean :required, default: false
      t.integer :position, null: false
    end
  end
end
