# frozen_string_literal: true

class UnemploymentCertificationDay
  CALENDAR_DAYS_OF_WEEK = 1..5
  ONE_MONTH = 28.days
  WAITING_PERIOD = 7.national_gov_org_weekdays

  def initialize(beginning_day:, week_type: nil, day_of_week: nil)
    if week_type && day_of_week
      raise ArgumentError, day_of_week unless CALENDAR_DAYS_OF_WEEK.include?(day_of_week)

      @value = next_month_date(beginning_day, week_type, day_of_week)
    else
      @value = (beginning_day + WAITING_PERIOD).beginning_of_week(:monday)
    end
  end

  def to_date
    @value
  end

  private

  def next_month_date(beginning_day, week_type, day_of_week)
    value_klass = NationalGovernmentOrganizationHoliday::Value

    (beginning_day + ONE_MONTH).downto(beginning_day) do |date|
      next unless week_type == WeekType.from_date(date) && day_of_week == date.wday

      return date if value_klass.new(date).on_weekday?

      date.prev_day.downto(date.prev_month) do |prev_date|
        next unless value_klass.new(prev_date).on_weekday?

        return prev_date
      end
    end
  end
end
