# frozen_string_literal: true

class AnswerFieldComponent < ApplicationViewComponent
  attr_reader :required

  def initialize(required:)
    super
    @required = required
  end
end