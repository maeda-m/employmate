# frozen_string_literal: true

class Issuance < ApplicationRecord
  belongs_to :user
  belongs_to :survey

  self.record_timestamps = false

  before_save do
    self.done = created_on.present?
  end

  after_create do
    task = user.find_todo_task(survey:)
    task.done!

    user.add_follows_task(task) unless done?
  end
end
