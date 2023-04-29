# frozen_string_literal: true

class StartButton::Component < ApplicationViewComponent
  attr_reader :caption

  def initialize(caption:)
    super
    @caption = caption
  end

  def survey_id
    Survey.profiles.first.id
  end
end
