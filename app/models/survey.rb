# frozen_string_literal: true

class Survey < ActiveYaml::Base
  include ActiveHash::Associations

  has_many :questionnaires

  scope :profiles, lambda {
    where(survey_type: 'profile').order(:id)
  }
end
