# frozen_string_literal: true

class Surveys::ProfilesController < ApplicationController
  before_action :require_not_registered_user

  layout 'survey'

  def index
    survey = Survey.profiles.find(params[:survey_id])
    @answer = Answer.new(survey:)
    @questions = survey.all_questions
  end
end
