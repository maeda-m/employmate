FactoryBot.define do
  factory :user do
    trait :with_registered do
      sequence :google_id do |n|
        "fake-id-#{n}"
      end
      profile { build(:profile) }
    end

    trait :with_anonymous do
      profile { build(:profile) }
    end

    trait :with_special_reason_profile do
      profile { build(:profile, :with_special_reason) }
    end
  end

  factory :profile do
    unemployed_on { Time.zone.now }
    unemployed_with_special_reason { false }
    unemployed_with_special_eligible { false }

    trait :with_special_reason do
      unemployed_with_special_reason { true }
    end
  end

  factory :questionnaire do
    sequence :position do |n|
      n
    end

    trait :with_initial_profile do
      survey { Survey.initial_profile }
    end
  end

  factory :question do
    sequence :position do |m|
      m
    end

    trait :date_type do
      answer_component_type { 'date' }
    end

    trait :yes_or_no_type do
      answer_component_type { 'yes_or_no' }
    end

    trait :with_unemployed_on do
      date_type
      answer_gateway_rule { 'unemployed_on' }
    end

    trait :with_special_reason do
      yes_or_no_type
      answer_gateway_rule { 'unemployed_with_special_reason' }
    end

    trait :with_special_eligible do
      answer_component_type { 'overtime' }
      answer_gateway_rule { 'unemployed_with_special_eligible' }
    end
  end

  factory :answer_condition do
    answered { false }
    equal { true }

    trait :with_never_match do
      condition_answer_value { 'not_match' }
    end
  end
end
