# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveHash::RecordNotFound, with: :active_hash_record_not_found
  protect_from_forgery with: :exception
  before_action :set_current_state

  private

  def active_hash_record_not_found(error)
    raise ActiveRecord::RecordNotFound, error.message
  end

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

  def require_not_registered_user
    user = Current.user

    redirect_to user_url(id: user.id) if user&.registered?
  end

  def require_anonymous_user
    return if Current.user&.anonymous?

    redirect_to root_url
  end

  def require_registered_user
    return if Current.user&.registered?

    redirect_to root_url
  end

  def signin_by(user)
    # See: https://guides.rubyonrails.org/security.html#session-fixation
    reset_session
    Current.session = Session.find_by!(session_id: current_session_id)
    Current.session.signin_by(user)
  end
end
