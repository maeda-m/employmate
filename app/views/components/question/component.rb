# frozen_string_literal: true

class Question::Component < ApplicationViewComponent
  delegate :body, :answer_component, :required, to: :@question

  attr_reader :title

  def initialize(component:, title:)
    @question = component
    @title = title
  end
end
