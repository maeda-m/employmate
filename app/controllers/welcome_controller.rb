# frozen_string_literal: true

class WelcomeController < ApplicationController
  before_action :require_not_registered_user, only: :index

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
