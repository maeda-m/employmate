# frozen_string_literal: true

class ScheduledTransferDay
  def initialize(beginning_day:)
    @value = beginning_day + 5.national_gov_org_weekdays
  end

  def to_date
    @value
  end
end
