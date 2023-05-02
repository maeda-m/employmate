# frozen_string_literal: true

class AnswerGateway < ActiveYaml::Base
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
end
