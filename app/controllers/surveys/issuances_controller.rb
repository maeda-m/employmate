# frozen_string_literal: true

class Surveys::IssuancesController < ApplicationController
  include AnswerParameter

  def create
    survey = Survey.find(params[:survey_id])
    user = Current.user

    ActiveRecord::Base.transaction do
      created_on = answer_values_to_event_history
      event_history = Issuance.create!(user:, survey:, created_on:, done: created_on.present?)

      user.update_profile_by!(survey:, answer_values:)
      task = user.find_todo_task(survey:)
      task.done!

      unless event_history.done?
        user.tasks.create!(position: 10, task_category: TaskCategory.fifth, title: '雇用保険受給資格者証を入手する',
                           survey: Survey.issued_employment_insurance_eligibility_card)
        task.update!(title: '雇用保険受給資格者証を入手する（仮）')
      end
    end

    redirect_to user_profile_url(user_id: user.id)
  end
end
