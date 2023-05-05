# frozen_string_literal: true

class Surveys::AnswersController < ApplicationController
  def create
    survey = Survey.find(params[:survey_id])

    raise NotImplementedError unless survey.type_of_profile?

    anonymous_user = nil
    ActiveRecord::Base.transaction do
      anonymous_user = User.create!
      Answer.create!(user: anonymous_user, survey:)

      attrs = AnswerGateway.to_profile_attributes(survey, answers_params)
      anonymous_user.create_profile!(attrs)
    end

    signin_by(anonymous_user)

    redirect_to user_profile_url(user_id: anonymous_user.id)
  end

  private

  def answers_params
    params.require(:answers)
    params.permit(answers: [:value, { values: %w[0 1 2 3 4 5] }])[:answers]
  end
end
