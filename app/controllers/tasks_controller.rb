# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :require_registered_user

  def update
    task = Current.session.user.tasks.todo.find(params[:id])
    task.done!

    redirect_to user_url(id: Current.session.user.id)
  end
end
