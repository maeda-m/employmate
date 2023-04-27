# frozen_string_literal: true

class Questionnaire::Component < ApplicationViewComponent
  delegate :title, :questions, to: :@questionnaire

  def initialize(component:)
    @questionnaire = component
  end
end
