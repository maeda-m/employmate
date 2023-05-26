# frozen_string_literal: true

class DateField::Component < AnswerFieldComponent
  def min
    Date.new(WeekType::LAW_PROMULGATED_YEAR.next, 1, 1)
  end
end
