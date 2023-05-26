# frozen_string_literal: true

class AnswerFieldComponent < ApplicationViewComponent
  attr_reader :description

  def initialize(question:, description: nil, user: nil)
    super
    @question = question
    @description = description
    @user = user
  end

  def record_name
    "answers[#{@question.id}]"
  end

  def subject
    @question.body
  end

  def required
    true
  end
end
