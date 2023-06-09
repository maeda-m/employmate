# frozen_string_literal: true

class Surveys::ProfilesController < ApplicationController
  skip_before_action :require_registered_user, only: :index
  before_action :require_not_registered_user

  def index
    survey = Survey.profiles.find(params[:survey_id])
    @answer = Answer.new(survey:)
    @questions = survey.all_questions
    @start_page_path = if params[:started_by] == StartButton::Component::STARTED_BY_REDO
                         user_profile_path(user_id: current_user.id)
                       else
                         root_path
                       end
    @page_title = @questions.first.title
  end
end
