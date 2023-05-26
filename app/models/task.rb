# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user
  belongs_to :task_category
  belongs_to :survey, optional: true

  scope :default_order, lambda {
    order(:position)
  }

  scope :todo, lambda {
    where(done: false).default_order
  }

  scope :done, lambda {
    where(done: true).default_order
  }

  def done!
    update!(done: true)
  end

  def about_when
    return task_category.name if task_category.now?

    date = task_category.estimated_date(user.profile)
    label = I18n.localize(date, format: :short)

    if task_category.fixed_date?(user.profile, date)
      label
    else
      label + task_category.label_suffix
    end
  end
end
