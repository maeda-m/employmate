# frozen_string_literal: true

class Users::ProfilesController < ApplicationController
  before_action :require_answerd_to_survey_profile_and_unregistered_user
  before_action :redirect_to_after_signin_url_if_registered_user?

  def show
  end
end
