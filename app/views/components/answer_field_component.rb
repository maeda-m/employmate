# frozen_string_literal: true

class AnswerFieldComponent < ApplicationViewComponent
  def initialize(question:, user: nil)
    super
    @question = question
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
