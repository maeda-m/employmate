# frozen_string_literal: true

class ReasonCodeField::Component < AnswerFieldComponent
  CODES = %w[11 12 21 22 23 24 25 31 32 33 34 40 45 50 55].freeze

  def choices
    CODES
  end
end
