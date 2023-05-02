# frozen_string_literal: true

class OvertimeField::Component < AnswerFieldComponent
  FIELD_COUNT = 6

  def self.generate_labels(numeric)
    raise ArgumentError unless /\A\d{4}-\d{1,2}\z/.match?(numeric)

    end_month = Date.parse("#{numeric}-01")
    months = Array.new(FIELD_COUNT) { |i| end_month - i.months }.reverse

    months.map { |m| I18n.localize(m, format: '%Y/%m') }
  end
end
