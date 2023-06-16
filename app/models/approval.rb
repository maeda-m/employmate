# frozen_string_literal: true

class Approval < ApplicationRecord
  belongs_to :user
  belongs_to :survey

  self.record_timestamps = false
  validates :created_on, presence: true

  after_create do
    user.find_todo_task(survey:).done!
  end
end
