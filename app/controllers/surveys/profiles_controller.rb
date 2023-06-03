# frozen_string_literal: true

class Surveys::ProfilesController < ApplicationController
  before_action :require_not_registered_user

  layout 'survey'

  def index
    survey = Survey.profiles.find(params[:survey_id])
    @answer = Answer.new(survey:)
    @questions = survey.all_questions
    @start_page_path = if params[:started_by] == StartButton::Component::STARTED_BY_REDO
                         user_profile_url(user_id: Current.user.id)
                       else
                         root_path
                       end
  end
end
