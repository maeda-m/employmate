# frozen_string_literal: true

class Surveys::QuestionsController < ApplicationController
  def next
    question = Survey.find(params[:survey_id]).next_question(params[:id])
    render plain: question_id(question)
  end

  def back
    question = Survey.find(params[:survey_id]).prev_question(params[:id])
    render plain: question_id(question)
  end

  private

  def question_id(question)
    return '' unless question

    ActionView::RecordIdentifier.dom_id(question)
  end
end
