# frozen_string_literal: true

class SessionsController < ApplicationController
  include GoogleOpenIdConnect

  skip_before_action :require_registered_user, only: :create

  def create
    # See: https://github.com/Sorcery/sorcery/blob/v0.16.5/lib/sorcery/controller.rb#L37
    user = login(authenticated_google_id)

    if user
      start_user_session(user)

      redirect_to user_url(id: user.id), notice: 'ログインしました。'
    else
      redirect_to root_url, notice: 'ログインできませんでした。'
    end
  end
end
