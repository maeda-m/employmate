# frozen_string_literal: true

class StartButton::Component < ApplicationViewComponent
  def survey_id
    Survey.profiles.first.id
  end
end
