# frozen_string_literal: true

module GoogleOpenIdConnect
  extend ActiveSupport::Concern

  included do
    # rubocop:disable Rails/LexicallyScopedActionFilter
    protect_from_forgery except: :create
    skip_before_action :set_current_state, only: :create
    before_action :protect_id_token_forgery, only: :create
    # rubocop:enable Rails/LexicallyScopedActionFilter
  end

  private

  def authenticated_google_id
    google_client_id = ENV['GOOGLE_OPENID_CONNECT_CLIENT_ID']
    payload = Google::Auth::IDTokens.verify_oidc(params[:credential], aud: google_client_id)
  rescue StandardError => e
    # See: https://www.rubydoc.info/github/google/google-auth-library-ruby/Google%2FAuth%2FIDTokens.verify_oidc
    # See: https://github.com/googleapis/google-auth-library-ruby/blob/main/test/id_tokens/verifier_test.rb
    reset_session
    raise ActionController::InvalidAuthenticityToken(e.full_message)
  else
    # See: https://openid.net/specs/openid-connect-core-1_0.html#IDToken
    payload['sub']
  end

  def protect_id_token_forgery
    # See: https://developers.google.com/identity/gsi/web/guides/verify-google-id-token?hl=ja
    if cookies['g_csrf_token'].blank? || params[:g_csrf_token].blank? || cookies['g_csrf_token'] != params[:g_csrf_token]
      reset_session
      raise ActionController::InvalidAuthenticityToken
    end

    # See: https://developers.google.com/identity/openid-connect/openid-connect?hl=ja#state-param
    begin
      authenticated_session = Session.find_by!(token: params[:state]).destroy!
    rescue ActiveRecord::ActiveRecordError => e
      reset_session
      raise ActionController::InvalidAuthenticityToken(e.full_message)
    end

    user = authenticated_session.user
    @anonymous_user = user unless user&.registered?
  end

  def anonymous_user
    @anonymous_user
  end
end
