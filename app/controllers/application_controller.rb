# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_current_authenticated_user

  private

  def set_current_authenticated_user
    Current.user = User.find_by(id: cookies.signed[:user_id])
  end
end
