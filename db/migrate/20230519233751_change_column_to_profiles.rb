# frozen_string_literal: true

class ChangeColumnToProfiles < ActiveRecord::Migration[7.0]
  def change
    rename_column :profiles, :first_unemployment_certification_on, :fixed_first_unemployment_certification_on
  end
end
