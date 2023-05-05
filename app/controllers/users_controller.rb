# frozen_string_literal: true

class UsersController < ApplicationController
  include GoogleOpenIdConnect

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
  end
end
