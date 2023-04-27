# frozen_string_literal: true

class Surveys::QuestionsController < ApplicationController
  def next
    @question = Survey.find(params[:survey_id]).next_question(params[:id])
  end

  def back
    @question = Survey.find(params[:survey_id]).prev_question(params[:id])
  end
end
