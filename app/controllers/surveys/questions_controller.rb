# frozen_string_literal: true

class Surveys::QuestionsController < ApplicationController
  include AnswerParameter

  before_action :require_not_registered_user

  def next
    current_question = Question.find(params[:id])
    next_question = Survey.find(params[:survey_id]).next_question(current_question, answer_values_without_next_questions(current_question))

    if next_question
      render turbo_stream: next_question_streams(current_question, next_question)
    else
      render turbo_stream: [
        turbo_stream.append(current_question, partial: 'hide_question', locals: { question: current_question }),
        turbo_stream.append('survey-profiles', partial: 'show_submit')
      ]
    end
  end

  def back
    current_question = Question.find(params[:id])
    prev_question = Survey.find(params[:survey_id]).prev_question(current_question, answer_values)

    render turbo_stream: [
      turbo_stream.append(current_question, partial: 'hide_question', locals: { question: current_question }),
      turbo_stream.append(prev_question, partial: 'show_question', locals: { question: prev_question })
    ]
  end

  private

  def next_question_streams(current_question, next_question)
    streams = [
      turbo_stream.append(current_question, partial: 'hide_question', locals: { question: current_question }),
      turbo_stream.append(next_question, partial: 'show_question', locals: { question: next_question })
    ]

    prev_answer = params[:answers].fetch(params[:id])[:value]
    partial_name = "show_#{next_question.answer_component_type}_field"
    if template_exists?("/surveys/questions/#{partial_name}", [], true)
      streams << turbo_stream.append(next_question, partial: partial_name, locals: { question: next_question, prev_answer: })
    end

    streams
  end
end
