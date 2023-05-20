# frozen_string_literal: true

class Profile < ApplicationRecord
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
    beginning_day = draft_explanitory_seminar_on_for_employment_insurance + benefit_restriction_period
    UnemploymentCertificationDay.new(beginning_day:).to_date
  end

  def benefit_restriction_period
    return 0.days if unemployed_with_special_eligible?
    return 0.days if unemployed_with_special_reason?

    # TODO: [ 11, 12, 21, 22, 23, 31, 32, 33, 34 ].include?(reason_code_for_loss_of_employment)
    2.months
  end

  def first_scheduled_transfer_on
    beginning_day = [
      first_unemployment_certification_on,
      employment_insurance_eligibility_card_issuance_on
    ].compact.max

    ScheduledTransferDay.new(beginning_day:).to_date
  end

  def employment_insurance_eligibility_card_issuance_on
    # TODO: user.issuances.where(done: true).first&.created_on
  end
end
