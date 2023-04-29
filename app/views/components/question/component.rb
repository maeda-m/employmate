# frozen_string_literal: true

class Question::Component < ApplicationViewComponent
  delegate :id, :body, :survey_id, :answer_component, :required, to: :@question
  delegate :field_component, to: :answer_component

  attr_reader :title

  def initialize(component:, title:)
    super
    @question = component
    @title = title
  end

  def question_id
    dom_id(@question)
  end
end
