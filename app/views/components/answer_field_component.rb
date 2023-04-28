# frozen_string_literal: true

class AnswerFieldComponent < ApplicationViewComponent
  attr_reader :record_name, :subject, :description, :required

  def initialize(record_name:, subject:, description:, required:)
    super
    @record_name = record_name
    @subject = subject
    @description = description
    @required = required
  end
end
