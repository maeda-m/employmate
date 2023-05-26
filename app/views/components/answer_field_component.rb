# frozen_string_literal: true

class AnswerFieldComponent < ApplicationViewComponent
  attr_reader :record_name, :subject, :description, :required

  def initialize(record_name:, required:, subject:, description: nil, user: nil)
    super
    @record_name = record_name
    @subject = subject
    @description = description
    @required = required
    @user = user
  end
end
