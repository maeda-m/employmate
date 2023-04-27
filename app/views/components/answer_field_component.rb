# frozen_string_literal: true

class AnswerFieldComponent < ApplicationViewComponent
  attr_reader :required

  def initialize(required:)
    @required = required
  end
end
