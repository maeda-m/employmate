# frozen_string_literal: true

class Surveys::ApprovalsController < ApplicationController
  include AnswerParameter

  before_action :require_registered_user

  def create
    survey = Survey.find(params[:survey_id])
    user = Current.user

    ActiveRecord::Base.transaction do
      created_on = answer_values_to_event_history
      Approval.create!(user:, survey:, created_on:)

      user.update_profile_by!(survey:, answer_values:)
      user.find_todo_task(survey:).done!
    end

    redirect_to user_profile_url(user_id: user.id)
  end
end
