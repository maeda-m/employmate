# frozen_string_literal: true

class Surveys::IssuancesController < ApplicationController
  include AnswerParameter

  before_action :require_registered_user

  def create
    survey = Survey.find(params[:survey_id])

    ActiveRecord::Base.transaction do
      created_on = answer_values_to_event_history_date
      Issuance.create!(user: current_user, survey:, created_on:)
      current_user.update_profile_by!(survey:, answer_values:)
    end

    redirect_to user_url(id: current_user.id), notice: '完了にしました。'
  end
end
