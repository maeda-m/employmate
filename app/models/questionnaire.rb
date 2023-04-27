# frozen_string_literal: true

class Questionnaire < ApplicationRecord
  belongs_to :survey

  has_many :questions, dependent: :destroy
end
