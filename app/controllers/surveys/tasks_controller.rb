# frozen_string_literal: true

class Surveys::TasksController < ApplicationController
  def index
    survey = Survey.tasks.find(params[:survey_id])
    @approval = Approval.new(survey:) if survey.approved_release_form?
    @issuance = Issuance.new(survey:) if survey.issued_employment_insurance_eligibility_card?
    @questions = survey.all_questions
    @page_title = @questions.first.title
  end
end
