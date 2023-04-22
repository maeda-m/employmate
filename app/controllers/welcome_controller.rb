# frozen_string_literal: true

class WelcomeController < ApplicationController
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
