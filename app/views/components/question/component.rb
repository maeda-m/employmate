# frozen_string_literal: true

class Question::Component < ApplicationViewComponent
  delegate :id, :body, :answer_component, :required, to: :@question
  delegate :field_component, to: :answer_component

  attr_reader :survey_id, :title

  def initialize(component:, survey_id:, title:)
    super
    @question = component
    @survey_id = survey_id
    @title = title
  end

  def frame_id
    dom_id(@question)
  end
end
