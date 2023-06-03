# frozen_string_literal: true

class StartButton::Component < ApplicationViewComponent
  STARTED_BY_TOP = 'welcome'
  STARTED_BY_REDO = 'redo_answer'

  CAPTIONS = {
    STARTED_BY_TOP => 'はじめる',
    STARTED_BY_REDO => 'やりなおす'
  }.freeze

  attr_reader :caption, :started_by

  def initialize(context:)
    super
    @caption = CAPTIONS[context]
    @started_by = context
  end

  def survey_id
    Survey.initial_profile.id
  end
end
