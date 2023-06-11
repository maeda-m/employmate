# frozen_string_literal: true

class RegisteredUser
  def self.create!(user, authenticated_google_id)
    raise ArgumentError, user unless user&.anonymous?

    user.register(authenticated_google_id)
    user.create_tasks

    user
  end
end
