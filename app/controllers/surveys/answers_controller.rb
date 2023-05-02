# frozen_string_literal: true

class Surveys::AnswersController < ApplicationController
  def create
    survey = Survey.find(params[:survey_id])

    if survey.type_of_profile?
      ActiveRecord::Base.transaction do
        user = User.create!
        Answer.create!(user:, survey:)

        attrs = AnswerGateway.to_profile_attributes(survey, answers_params)
        user.create_profile!(attrs)

        reset_session
        Current.user = user
        cookies.signed[:user_id] = { value: user.id, httponly: true }
      end
    end

    redirect_to user_profile_url(user_id: Current.user.id)
  end

  private

  def answers_params
    params.require(:answers)
    params.permit(answers: [:value, { values: %w[0 1 2 3 4 5] }])[:answers]
  end
end
