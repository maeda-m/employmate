# frozen_string_literal: true

module GoogleOpenIdConnect
  extend ActiveSupport::Concern

  included do
    # rubocop:disable Rails/LexicallyScopedActionFilter
    skip_before_action :verify_authenticity_token, only: :create
    skip_before_action :set_current_state, only: :create
    before_action :protect_id_token_forgery, only: :create
    before_action :set_authenticated_session, only: :create
    # rubocop:enable Rails/LexicallyScopedActionFilter
  end

  private

  def authenticated_google_id
    payload = Google::Auth::IDTokens.verify_oidc(params[:credential], aud: Employmate.config.google_client_id)
  rescue StandardError => e
    # See: https://www.rubydoc.info/github/google/google-auth-library-ruby/Google%2FAuth%2FIDTokens.verify_oidc
    # See: https://github.com/googleapis/google-auth-library-ruby/blob/main/test/id_tokens/verifier_test.rb
    openid_connect_error_with_reset_session(e.message)
  else
    # See: https://openid.net/specs/openid-connect-core-1_0.html#IDToken
    payload['sub']
  end

  # NOTE: このモジュールを利用するコントローラーの create アクションは IdP となる Google が POST する
  def protect_id_token_forgery
    # See: https://developers.google.com/identity/gsi/web/guides/verify-google-id-token?hl=ja
    return if cookies['g_csrf_token'].present? && params[:g_csrf_token].present? && cookies['g_csrf_token'] == params[:g_csrf_token]

    openid_connect_error_with_reset_session('Failed to verify double submit cookie.')
  end

  def set_authenticated_session
    # See: https://developers.google.com/identity/openid-connect/openid-connect?hl=ja#state-param
    @authenticated_session = Session.authenticate_by_token(params[:state])
    @authenticated_session.destroy!
  rescue ActiveRecord::ActiveRecordError => e
    openid_connect_error_with_reset_session(e.message)
  end

  def openid_connect_error_with_reset_session(message)
    Rails.logger.error("[GoogleOpenIdConnect] #{message} via #{current_session_id}")

    reset_session
    raise ActionController::InvalidAuthenticityToken, message
  end
end
