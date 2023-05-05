# frozen_string_literal: true

class WelcomeController < ApplicationController
  before_action :redirect_to_after_signin_url_if_registered_user?

  def index
  end

  def terms_of_service
  end

  def privacy_policy
  end

  def robots
    @disallowed_path = '/' unless ENV['ROBOTS_INDEX']
  end
end
