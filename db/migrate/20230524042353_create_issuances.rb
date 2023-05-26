# frozen_string_literal: true

class CreateIssuances < ActiveRecord::Migration[7.0]
  def change
    create_table :issuances do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :survey, null: false, foreign_key: false
      t.boolean :done, default: false
      t.date :created_on, null: true, comment: '交付履歴として仮発行があるためNULL制約は不要と判断した'
    end

    add_index :issuances, %i[user_id survey_id done], unique: true
  end
end
