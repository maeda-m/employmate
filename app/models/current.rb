# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  attribute :session

  def user
    session&.user
  end

  def signin?
    !user.nil?
  end
end
