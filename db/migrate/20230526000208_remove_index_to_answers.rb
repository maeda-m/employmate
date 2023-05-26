# frozen_string_literal: true

class RemoveIndexToAnswers < ActiveRecord::Migration[7.0]
  def change
    # NOTE: 調査をやりなおしたときに重複が発生するためユニーク制約を削除した
    remove_index :answers, %i[user_id survey_id], unique: true
  end
end
