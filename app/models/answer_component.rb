# frozen_string_literal: true

class AnswerComponent < ActiveYaml::Base
  def field_component
    klass = "#{type}_field/component".camelize
    AnswerFieldComponent.const_get(klass)
  end

  def date?
    type.inquiry.date?
  end

  def yes_or_no?
    type.inquiry.yes_or_no?
  end

  def overtime?
    type.inquiry.overtime?
  end
end
