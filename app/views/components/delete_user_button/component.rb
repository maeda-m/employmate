# frozen_string_literal: true

class DeleteUserButton::Component < ApplicationViewComponent
  def initialize(user:)
    super
    @user = user
  end

  def user_id
    @user.id
  end

  def render?
    @user&.registered?
  end
end
