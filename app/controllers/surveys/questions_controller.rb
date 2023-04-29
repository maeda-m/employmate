# frozen_string_literal: true

class Surveys::QuestionsController < ApplicationController
  def next
    question = Survey.find(params[:survey_id]).next_question(params[:id])

    if question
      streams = [
        turbo_stream.append('survey-profiles', partial: 'show_question', locals: { question: })
      ]

      if question.answer_component.overtime?
        prev_answer = params.require(:answers).fetch(params[:id])[:value]
        streams << turbo_stream.append(question, partial: '/components/overtime_field/show_field', locals: { question:, prev_answer: })
      end

      render turbo_stream: streams
    else
      render turbo_stream: turbo_stream.append('survey-profiles', partial: 'show_submit')
    end
  end

  def back
    question = Survey.find(params[:survey_id]).prev_question(params[:id])

    if question
      render turbo_stream: turbo_stream.append('survey-profiles', partial: 'show_question', locals: { question: })
    else
      render turbo_stream: turbo_stream.append('survey-profiles', partial: 'visit_welcome')
    end
  end
end
