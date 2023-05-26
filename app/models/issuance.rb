# frozen_string_literal: true

class Issuance < ApplicationRecord
  belongs_to :user
  belongs_to :survey
end
