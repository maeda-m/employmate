# frozen_string_literal: true

class Profile < ApplicationRecord
  INVOLUNTARILY_REASON_CODES = %w[11 12 21 22 23 31 32 33 34].freeze
  SERIOUS_REASON_CODES = %w[50 55].freeze

  belongs_to :user

  def after_unemployed_on
    unemployed_on.next_day
  end

  def issuanced_on_of_release_form
    after_unemployed_on + 10.days
  end

  def explanitory_seminar_on_for_employment_insurance
    fixed_explanitory_seminar_on_for_employment_insurance.presence ||
      draft_explanitory_seminar_on_for_employment_insurance
  end

  def draft_explanitory_seminar_on_for_employment_insurance
    issuanced_on_of_release_form + 7.national_gov_org_weekdays
  end

  def first_unemployment_certification_on
    fixed_first_unemployment_certification_on.presence ||
      draft_unemployment_certification_on
  end

  def draft_unemployment_certification_on
    beginning_day = draft_explanitory_seminar_on_for_employment_insurance
    UnemploymentCertificationDay.new(beginning_day:).to_date
  end

  def next_unemployment_certification_on(beginning_day)
    UnemploymentCertificationDay.new(
      beginning_day:,
      week_type: week_type_for_unemployment_certification.to_i,
      day_of_week: day_of_week_for_unemployment_certification.to_i
    ).to_date
  end

  def final_benefit_restriction_on
    first_unemployment_certification_on + benefit_restriction_period
  end

  def benefit_restriction_period
    if reason_code_for_loss_of_employment
      return 0.days if INVOLUNTARILY_REASON_CODES.include?(reason_code_for_loss_of_employment)
      return 3.months if SERIOUS_REASON_CODES.include?(reason_code_for_loss_of_employment)
    else
      return 0.days if unemployed_with_special_eligible?
      return 0.days if unemployed_with_special_reason?
    end

    2.months
  end

  def first_scheduled_transfer_on
    beginning_day = [
      final_benefit_restriction_on,
      employment_insurance_eligibility_card_issuance_on
    ].compact.max

    ScheduledTransferDay.new(beginning_day:).to_date
  end

  def employment_insurance_eligibility_card_issuance_on
    user.issuances.where(done: true).first&.created_on
  end
end
