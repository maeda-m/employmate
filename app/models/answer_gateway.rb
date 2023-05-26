# frozen_string_literal: true

class AnswerGateway < ActiveYaml::Base
  def to_profile(values)
    return Profile.new[rule] if values.empty?

    multiple_questions ? values.all? : values.first
  end

  def eval_date(value)
    return nil if value.blank?

    Date.parse(value)
  end

  def eval_yes_or_no(value)
    value == 'yes'
  end

  def eval_overtime(overtimes)
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

  def eval_with_compact_blank(value)
    return nil if value.blank?

    value
  end
  alias eval_week_type eval_with_compact_blank
  alias eval_day_of_week eval_with_compact_blank
  alias eval_reason_code eval_with_compact_blank
end
