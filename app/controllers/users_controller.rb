# frozen_string_literal: true

class UsersController < ApplicationController
  include GoogleOpenIdConnect

  before_action :require_registered_user, except: :create

  def show
  end

  def create
    registered_user = User.find_by_hash_google_id(authenticated_google_id)
    if registered_user
      signin_by(registered_user)

      redirect_to user_url(id: registered_user.id), notice: 'ログインしました。'
    else
      anonymous_user.register(authenticated_google_id)
      signin_by(anonymous_user)

      redirect_to user_url(id: anonymous_user.id), notice: '会員登録しました。'
    end
  end

  def destroy
    user_id = params[:id]
    raise ActiveRecord::RecordNotFound, user_id unless user_id == Current.user.id.to_s

    Current.user.destroy!

    redirect_to root_url, notice: '退会しました。'
  end
end
