# frozen_string_literal: true

class Surveys::ApprovalsController < ApplicationController
  include AnswerParameter

  before_action :require_registered_user

  def create
    survey = Survey.find(params[:survey_id])

    ActiveRecord::Base.transaction do
      created_on = answer_values_to_event_history
      Approval.create!(user: current_user, survey:, created_on:)

      current_user.update_profile_by!(survey:, answer_values:)
      current_user.find_todo_task(survey:).done!
    end

    redirect_to user_path(id: current_user.id), notice: '完了にしました。'
  end
end
