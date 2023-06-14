# frozen_string_literal: true

class DateField::Component < AnswerFieldComponent
  def min_date
    Date.new(WeekType::LAW_PROMULGATED_YEAR.next, 1, 1)
  end

  def placeholder
    I18n.localize(Date.new(2023, 2, 28))
  end
end
