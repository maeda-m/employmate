# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user
  belongs_to :task_category
  belongs_to :survey, optional: true

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
