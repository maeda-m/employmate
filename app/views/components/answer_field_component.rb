# frozen_string_literal: true

class AnswerFieldComponent < ApplicationViewComponent
  attr_reader :survey_id, :question_id, :subject, :description, :required

  def initialize(survey_id:, question_id:, subject:, description:, required:)
    super
    @survey_id = survey_id
    @question_id = question_id
    @subject = subject
    @description = description
    @required = required
  end

  def record_name
    "answers[#{question_id}]"
  end
end
