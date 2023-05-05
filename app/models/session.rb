# frozen_string_literal: true

class Session < ActiveRecord::SessionStore::Session
  belongs_to :user, optional: true

  before_create do
    self.token = SecureRandom.hex(32)
  end

  def signin_by(user)
    raise ActiveRecord::RecordNotFound unless user&.id

    update_column(:user_id, user.id) # rubocop:disable Rails/SkipsModelValidations
  end
end
