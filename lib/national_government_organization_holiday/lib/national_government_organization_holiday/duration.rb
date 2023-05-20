# frozen_string_literal: true

require_relative 'value'
require 'active_support/duration'

module NationalGovernmentOrganizationHoliday
  class Duration < ActiveSupport::Duration
    MIN_PLUS_DAYS = 1
    MAX_PLUS_DAYS = 7

    def initialize(plus_days)
      raise TypeError unless plus_days.is_a?(Integer)
      raise ArgumentError unless (MIN_PLUS_DAYS..MAX_PLUS_DAYS).cover?(plus_days)

      # See: https://github.com/rails/rails/blob/v7.0.4.3/activesupport/lib/active_support/duration.rb#L166-L167
      super(plus_days * SECONDS_PER_DAY, { days: plus_days }, true)
    end

    # See: https://github.com/rails/rails/blob/v7.0.4.3/activesupport/lib/active_support/core_ext/date/calculations.rb#L90-L98
    def since(beginning_day)
      weekdays = []

      plus_days = parts[:days]
      max_day = beginning_day.next_month
      beginning_day.next.upto(max_day) do |next_day|
        weekdays << next_day if Value.new(next_day).on_weekday?

        break if weekdays.count == plus_days
      end

      weekdays.last
    end
  end
end
