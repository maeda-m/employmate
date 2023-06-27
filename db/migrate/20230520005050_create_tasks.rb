# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :task_category, null: false, foreign_key: false
      t.belongs_to :survey, null: true, foreign_key: false
      t.boolean :done, default: false
      t.integer :position, null: false

      t.timestamps
    end
  end
end
