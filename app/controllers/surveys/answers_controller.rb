# frozen_string_literal: true

class Surveys::AnswersController < ApplicationController
  include AnswerParameter

  def create
    survey = Survey.find(params[:survey_id])

    ActiveRecord::Base.transaction do
      # NOTE: 初回分析調査への回答時に匿名ユーザーとして登録する
      signin_by(AnonymousUser.create!) unless Current.signin?

      user = Current.user
      Answer.create!(user:, survey:)
      user.update_profile_by!(survey:, answer_values:)
    end

    redirect_to user_profile_url(user_id: Current.user.id)
  end
end
