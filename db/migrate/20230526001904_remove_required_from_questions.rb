# frozen_string_literal: true

class RemoveRequiredFromQuestions < ActiveRecord::Migration[7.0]
  def change
    # NOTE: ほとんどの場合、必須入力であるためカラムは不要と判断した
    remove_column :questions, :required, :boolean, default: false
  end
end
