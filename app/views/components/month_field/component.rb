# frozen_string_literal: true

class MonthField::Component < AnswerFieldComponent
  def default_value
    Time.zone.today
  end

  def min_year
    WeekType::LAW_PROMULGATED_YEAR.next
  end
end
