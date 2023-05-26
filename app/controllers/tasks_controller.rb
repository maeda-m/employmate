# frozen_string_literal: true

class TasksController < ApplicationController
  def update
    task = Current.session.user.tasks.todo.find(params[:id])
    task.done!

    redirect_to user_url(id: Current.session.user.id)
  end
end
