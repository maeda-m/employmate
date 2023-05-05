# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_state

  private

  def set_current_state
    reset_session unless current_session_id
    Current.session = Session.find_by!(session_id: current_session_id)
  rescue ActiveRecord::RecordNotFound
    reset_session
    retry
  end

  def current_session_id
    session.id&.private_id
  end

  def redirect_to_after_signin_url_if_registered_user?
    user = Current.user

    redirect_to user_url(id: user.id) if user&.registered?
  end

  def require_answerd_to_survey_profile_and_unregistered_user
    user = Current.user
    return if user && !user.registered?

    redirect_to root_url
  end

  def require_registered_user
    user = Current.user
    return if user&.registered?

    redirect_to root_url
  end

  def signin_by(user)
    # See: https://guides.rubyonrails.org/security.html#session-fixation
    reset_session
    Current.session = Session.find_by!(session_id: current_session_id)
    Current.session.signin_by(user)
  end
end
