# frozen_string_literal: true

class Users::ProfilesController < ApplicationController
  before_action :require_not_registered_user
  before_action :require_anonymous_user

  def show
  end
end
