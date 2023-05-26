# frozen_string_literal: true

class Task::Component < ApplicationViewComponent
  attr_reader :task

  with_collection_parameter :task

  def initialize(task:)
    super
    @task = task
  end

  def form_action
    if task.survey
      survey_tasks_path(survey_id: task.survey_id)
    else
      task_path(id: task.id)
    end
  end

  def done_or_survey
    if task.survey
      'input->tasks#survey'
    else
      'input->tasks#done'
    end
  end

  def field_id
    dom_id(task)
  end
end
