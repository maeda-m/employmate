# frozen_string_literal: true

class AnswerGateway < ActiveYaml::Base
  def cast_value(answer_values, questions)
    values = answer_values.slice(questions.map(&:id)).map(&:cast_value)

    default_value = Profile.new[rule]
    return default_value if values.empty?

    multiple_questions ? values.all? : values.first
  end

  def cast_date(value)
    return nil if value.blank?

    Date.parse(value)
  end

  def cast_yes_or_no(value)
    value == 'yes'
  end

  def cast_overtime(overtimes)
    return false unless overtimes.any? { |v| v >= 45 }
    return true if overtimes.any? { |v| v >= 100 }

    result = false
    5.times do |i|
      result = true if (overtimes.slice(i, 2).sum(0.0) / 2) >= 80
    end
    4.times do |i|
      result = true if overtimes.slice(i, 3).all? { |v| v >= 45 }
    end

    result
  end

  def cast_with_compact_blank(value)
    return nil if value.blank?

    value
  end
  alias cast_week_type cast_with_compact_blank
  alias cast_day_of_week cast_with_compact_blank
  alias cast_reason_code cast_with_compact_blank
end
