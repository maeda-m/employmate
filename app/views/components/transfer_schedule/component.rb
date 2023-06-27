# frozen_string_literal: true

class TransferSchedule::Component < ApplicationViewComponent
  Value = Data.define(:unemployment_certification_date, :scheduled_transfer_date)

  def initialize(user:)
    super
    @user = user
  end

  def values
    results = []
    user_profile = @user.profile
    3.times.inject(user_profile.final_benefit_restriction_on) do |date, _i|
      beginning_day = user_profile.next_unemployment_certification_on(date)
      results << Value.new(beginning_day, ScheduledTransferDay.new(beginning_day:).to_date)

      beginning_day
    end

    results
  end
end
