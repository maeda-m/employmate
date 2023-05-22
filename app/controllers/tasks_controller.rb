# frozen_string_literal: true

class TasksController < ApplicationController
  def update
    task = Current.session.user.tasks.todo.find(params[:id])
    task.update!(task_params)

    redirect_to user_url(id: Current.session.user.id)
  end

  private

  def task_params
    params.require(:task).permit(:done)
  end
end
