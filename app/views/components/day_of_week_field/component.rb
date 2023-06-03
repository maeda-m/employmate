# frozen_string_literal: true

class DayOfWeekField::Component < RadioButtonField::Component
  CAPTIONS = %w[日 月 火 水 木 金 土].freeze

  def choices
    UnemploymentCertificationDay::CALENDAR_DAYS_OF_WEEK.map do |day_of_week|
      [day_of_week, CAPTIONS[day_of_week]]
    end
  end
end
