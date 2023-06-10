# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :require_registered_user

  def update
    task = current_user.tasks.todo.find(params[:id])
    task.done!

    redirect_to user_url(id: current_user.id)
  end
end
