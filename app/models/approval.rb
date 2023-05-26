# frozen_string_literal: true

class Approval < ApplicationRecord
  belongs_to :user
  belongs_to :survey
end
