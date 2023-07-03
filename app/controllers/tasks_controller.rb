# frozen_string_literal: true

class TasksController < ApplicationController
  def update
    task = current_user.tasks.todo.find(params[:id])
    task.done!

    redirect_to user_url(id: current_user.id), notice: '完了にしました。'
  end
end
