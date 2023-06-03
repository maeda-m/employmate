# frozen_string_literal: true

class WeekTypeField::Component < RadioButtonField::Component
  def choices
    WeekType::VALUES.map do |value|
      [value, value]
    end
  end
end
