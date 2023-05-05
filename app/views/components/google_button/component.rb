# frozen_string_literal: true

class GoogleButton::Component < ApplicationViewComponent
  attr_reader :context, :state

  def initialize(context:, state:)
    super
    @context = context
    @state = state
  end

  def client_id
    ENV['GOOGLE_OPENID_CONNECT_CLIENT_ID']
  end

  def redirect_url
    if signin?
      sessions_url
    else
      users_url
    end
  end

  def caption
    "#{context}_with"
  end

  private

  def signin?
    @context.inquiry.signin?
  end
end
