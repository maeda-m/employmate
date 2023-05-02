# frozen_string_literal: true

class Surveys::AnswersController < ApplicationController
  def create
    survey = Survey.find(params[:survey_id])

    raise NotImplementedError if survey.type_of_profile?

    redirect_to user_profile_url(user_id: 'TODO')
  end

  private

  def answers_params
    params.require(:answers)
    params.permit(answers: [:value, { values: %w[0 1 2 3 4 5] }])[:answers]
  end
end
