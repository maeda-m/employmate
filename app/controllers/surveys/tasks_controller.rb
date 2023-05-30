# frozen_string_literal: true

class Surveys::TasksController < ApplicationController
  before_action :require_registered_user

  layout 'survey'

  def index
    survey = Survey.tasks.find(params[:survey_id])
    @approval = Approval.new(survey:) if survey.approved_release_form?
    @issuance = Issuance.new(survey:) if survey.issued_employment_insurance_eligibility_card?
    @questions = survey.all_questions
  end
end
