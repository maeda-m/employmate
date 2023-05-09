# frozen_string_literal: true

require_relative 'duration'
require 'active_support/core_ext/numeric/time'

module NationalGovernmentOrganizationHoliday
  module IntegerPatch
    def national_gov_org_weekdays
      NationalGovernmentOrganizationHoliday::Duration.new(self)
    end
    alias national_gov_org_weekday national_gov_org_weekdays
  end
end

NationalGovernmentOrganizationHoliday::IntegerPatch.then do |mod|
  Integer.send(:prepend, mod) unless Integer.include?(mod)
end
