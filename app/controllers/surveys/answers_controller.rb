# frozen_string_literal: true

class Surveys::AnswersController < ApplicationController
  include AnswerParameter

  before_action :require_not_registered_user

  def create
    survey = Survey.find(params[:survey_id])

    ActiveRecord::Base.transaction do
      # NOTE: 初回分析調査への回答時に匿名ユーザーとして登録する
      start_user_session(AnonymousUser.create!) unless current_user&.anonymous?

      Answer.create!(user: current_user, survey:)
      current_user.update_profile_by!(survey:, answer_values:)
    end

    redirect_to user_profile_url(user_id: current_user.id)
  end
end
