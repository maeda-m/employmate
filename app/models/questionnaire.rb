# frozen_string_literal: true

class Questionnaire < ApplicationRecord
  belongs_to :survey

  has_many :questions, dependent: :destroy

  scope :with_questions, lambda { |position|
    eager_load(:questions).merge(Question.where(position:).default_order)
  }
end
