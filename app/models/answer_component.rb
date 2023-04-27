# frozen_string_literal: true

class AnswerComponent < ActiveYaml::Base
  def field_component
    klass = "#{type}_field/component".camelize
    AnswerFieldComponent.const_get(klass)
  end

  def automatable?
    %w[yes_or_no yes_or_no_with_not_applicable].include?(type)
  end
end
