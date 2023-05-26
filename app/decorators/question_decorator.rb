# frozen_string_literal: true

module QuestionDecorator
  delegate :field_component, to: :answer_component
end
