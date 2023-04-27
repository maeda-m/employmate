# frozen_string_literal: true

class ProfileAnswer::Component < ApplicationViewComponent
  delegate :field_component, :automatable?, to: :@answer_component

  attr_reader :required

  def initialize(answer_component:, required:)
    @answer_component = answer_component
    @required = required
  end
end
