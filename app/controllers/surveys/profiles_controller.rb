# frozen_string_literal: true

class Surveys::ProfilesController < ApplicationController
  def index
    @survey = Survey.profiles.find(params[:survey_id])
    @questionnaires = @survey.questionnaires.includes([:questions]).order(:position)
  end
end
