# frozen_string_literal: true

class SigninButton::Component < ApplicationViewComponent
  def client_id
    ENV['GOOGLE_OPENID_CONNECT_CLIENT_ID']
  end
end
