# frozen_string_literal: true

class AnonymousUser
  def self.create!
    user = User.create!
    user.create_profile!

    user
  end
end
