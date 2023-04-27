# frozen_string_literal: true

class CreateQuestionnaires < ActiveRecord::Migration[7.0]
  def change
    create_table :questionnaires do |t|
      t.belongs_to :survey, null: false, foreign_key: false
      t.string :title
      t.integer :position, null: false
    end
  end
end
