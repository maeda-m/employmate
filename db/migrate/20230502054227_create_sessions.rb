# frozen_string_literal: true

class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.string :session_id, null: false, index: { unique: true }
      t.belongs_to :user, null: true, foreign_key: true
      t.string :token, null: false
      t.text :data
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false, index: true
    end
  end
end
