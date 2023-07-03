# frozen_string_literal: true

class UsersController < ApplicationController
  include GoogleOpenIdConnect

  skip_before_action :require_registered_user, only: :create

  def show
    @scheduled_transfer_label = current_user.tasks.new(task_category: TaskCategory.sixth).about_when
    @tasks_with_category = current_user.tasks.todo.group_by(&:task_category)
    @done_tasks = current_user.tasks.done
  end

  def create
    # See: https://github.com/Sorcery/sorcery/blob/v0.16.5/lib/sorcery/controller.rb#L37
    registered_user = login(authenticated_google_id)

    message = registered_user ? 'ログインしました。' : '会員登録しました。'
    registered_user ||= RegisteredUser.create!(anonymous_user, authenticated_google_id)

    start_user_session(registered_user)
    redirect_to user_url(id: registered_user.id), notice: message
  end

  def destroy
    user_id = params[:id]
    raise ActiveRecord::RecordNotFound, user_id unless user_id == current_user.id.to_s

    current_user.destroy!

    # See: https://github.com/Sorcery/sorcery/blob/v0.16.5/lib/sorcery/controller.rb#L71
    logout
    redirect_to root_url, notice: '退会しました。'
  end

  private

  def anonymous_user
    @authenticated_session.user
  end
end
