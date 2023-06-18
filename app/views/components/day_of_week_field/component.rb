# frozen_string_literal: true

class DayOfWeekField::Component < RadioButtonField::Component
  def choices
    captions = I18n.translate('date.abbr_day_names')
    UnemploymentCertificationDay::CALENDAR_DAYS_OF_WEEK.map do |day_of_week|
      [day_of_week, captions[day_of_week]]
    end
  end
end
