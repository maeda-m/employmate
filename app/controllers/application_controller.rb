# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveHash::RecordNotFound, with: :active_hash_record_not_found
  protect_from_forgery with: :exception

  helper_method :current_session

  private

  def active_hash_record_not_found(error)
    raise ActiveRecord::RecordNotFound, error.message
  end

  def current_session
    raise ActiveRecord::RecordNotFound unless current_session_id

    if @current_session&.session_id == current_session_id
      @current_session
    else
      @current_session = Session.find_current!(current_session_id)
    end
  rescue ActiveRecord::RecordNotFound
    reset_session
    retry
  end

  def current_session_id
    session.id&.private_id
  end

  def require_not_registered_user
    redirect_to user_url(id: current_user.id) if current_user&.registered?
  end

  def require_anonymous_user
    return if current_user&.anonymous?

    redirect_to root_url
  end

  def require_registered_user
    return if current_user&.registered?

    redirect_to root_url
  end

  # See: https://github.com/Sorcery/sorcery/blob/v0.16.5/lib/sorcery/controller.rb#L116
  def auto_login(user, _should_remember = nil)
    current_session.current_user = user
    @current_user = user
  end
  alias start_user_session auto_login

  # See: https://github.com/Sorcery/sorcery/blob/v0.16.5/lib/sorcery/controller.rb#L139
  def login_from_session
    @current_user = current_session.user
  end
end
