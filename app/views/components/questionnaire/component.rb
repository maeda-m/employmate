# frozen_string_literal: true

class Questionnaire::Component < ApplicationViewComponent
  delegate :survey_id, :title, :questions, to: :@questionnaire

  def initialize(component:)
    super
    @questionnaire = component
  end
end
