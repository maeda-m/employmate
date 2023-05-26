# frozen_string_literal: true

class Surveys::ProfilesController < ApplicationController
  before_action :require_not_registered_user

  def index
    survey = Survey.profiles.find(params[:survey_id])
    @answer = Answer.new(survey:)
    @questionnaires = survey.questionnaires.includes([:questions])
  end
end
