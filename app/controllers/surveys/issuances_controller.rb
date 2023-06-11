# frozen_string_literal: true

class Surveys::IssuancesController < ApplicationController
  include AnswerParameter

  before_action :require_registered_user

  def create
    survey = Survey.find(params[:survey_id])

    ActiveRecord::Base.transaction do
      created_on = answer_values_to_event_history
      event_history = Issuance.create!(user: current_user, survey:, created_on:, done: created_on.present?)

      current_user.update_profile_by!(survey:, answer_values:)
      task = current_user.find_todo_task(survey:)
      task.done!

      unless event_history.done?
        current_user.tasks.create!(position: 10, task_category: TaskCategory.fifth, title: '雇用保険受給資格者証を入手する',
                                   survey: Survey.issued_employment_insurance_eligibility_card)
        task.update!(title: '雇用保険受給資格者証を入手する（仮）')
      end
    end

    redirect_to user_profile_url(user_id: current_user.id)
  end
end
