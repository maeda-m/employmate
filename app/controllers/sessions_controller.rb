# frozen_string_literal: true

class SessionsController < ApplicationController
  include GoogleOpenIdConnect

  def create
    user = User.find_by_hash_google_id(authenticated_google_id)

    if user
      signin_by(user)

      redirect_to user_url(id: user.id), notice: 'ログインしました。'
    else
      redirect_to root_url, alert: 'ログインできませんでした。'
    end
  end
end
