# frozen_string_literal: true

class Surveys::QuestionsController < ApplicationController
  def next
    current_question = Question.find(params[:id])
    next_question = Survey.find(params[:survey_id]).next_question(current_question)

    streams = [
      turbo_stream.append(current_question, partial: 'hide_question', locals: { question: current_question })
    ]

    if next_question
      streams << turbo_stream.append(next_question, partial: 'show_question', locals: { question: next_question })

      if next_question.answer_component.overtime?
        prev_answer = params.require(:answers).fetch(params[:id])[:value]
        streams << turbo_stream.append(next_question, partial: '/components/overtime_field/show_field', locals: { question: next_question, prev_answer: })
      end
    else
      streams << turbo_stream.append('survey-profiles', partial: 'show_submit')
    end

    render turbo_stream: streams
  end

  def back
    current_question = Question.find(params[:id])
    prev_question = Survey.find(params[:survey_id]).prev_question(current_question)

    if prev_question
      render turbo_stream: [
        turbo_stream.append(current_question, partial: 'hide_question', locals: { question: current_question }),
        turbo_stream.append(prev_question, partial: 'show_question', locals: { question: prev_question })
      ]
    else
      render turbo_stream: turbo_stream.append('survey-profiles', partial: 'visit_welcome')
    end
  end
end
