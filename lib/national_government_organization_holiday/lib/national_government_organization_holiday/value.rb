# frozen_string_literal: true

require 'holiday_japan'

module NationalGovernmentOrganizationHoliday
  class Value
    def initialize(value)
      @value = value
    end

    # See: https://elaws.e-gov.go.jp/document?lawid=363AC0000000091
    def on_weekday?
      return false if @value.on_weekend?
      return false if on_new_year_holiday_season?
      return false if @value.national_holiday?

      true
    end

    def on_new_year_holiday_season?
      current_year = @value.year
      new_year = Date.new(current_year, 1, 1)..Date.new(current_year, 1, 3)
      year_end = Date.new(current_year, 12, 29)..Date.new(current_year, 12, 31)

      new_year.cover?(@value) || year_end.cover?(@value)
    end
  end
end
