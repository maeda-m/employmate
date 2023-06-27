# frozen_string_literal: true

class WeekType
  VALUES = 1..4
  LAW_PROMULGATED_YEAR = 1974
  LAW_PROMULGATED_WEEK_TYPE = VALUES.last

  def initialize(value)
    raise ArgumentError, value unless VALUES.include?(value)

    @value = value
  end

  def add
    if @value == VALUES.last
      @value = VALUES.first
    else
      @value += 1
    end
  end

  def to_i
    @value
  end

  def to_s
    @value
  end

  def self.beginning_of_year(target_year)
    raise ArgumentError, target_year if target_year < LAW_PROMULGATED_YEAR

    value = new(LAW_PROMULGATED_WEEK_TYPE)
    (LAW_PROMULGATED_YEAR.next..target_year).step(1) do |year|
      beginning_of_year = Date.new(year, 1, 1)

      value.add if beginning_of_year.sunday?
      value.add if beginning_of_year.monday? && Date.leap?(year - 1)
    end

    value.to_i
  end

  def self.from_date(date)
    value = new(beginning_of_year(date.year))
    (date.beginning_of_year.next_day..date).step(1) do |day|
      value.add if day.sunday?
    end

    value.to_i
  end
end
