# frozen_string_literal: true

class WeekTypeField::Component < RadioButtonField::Component
  def choices
    WeekType::VALUES.map do |value|
      [value, value]
    end
  end

  def choice_action
  end

  def choice_wrapper
    'grid'
  end
end
