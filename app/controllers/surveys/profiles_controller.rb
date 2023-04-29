# frozen_string_literal: true

class Surveys::ProfilesController < ApplicationController
  def index
    # TODO: Answer.new(survey:)
    @survey = Survey.profiles.find(params[:survey_id])
    @questionnaires = @survey.questionnaires.includes([:questions]).order(:position)
  end
end
