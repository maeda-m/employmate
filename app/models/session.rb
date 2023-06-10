# frozen_string_literal: true

class Session < ActiveRecord::SessionStore::Session
  belongs_to :user, optional: true

  before_create do
    self.token = SecureRandom.hex(32)
  end

  # NOTE: Google::Auth::IDTokens の有効期限は1時間だが、スマートフォンで入力途中だった場合を考慮している
  scope :validity_days, lambda {
    where(created_at: Range.new(7.days.ago, nil))
  }

  def self.find_current!(session_id)
    validity_days.find_by!(session_id:)
  end

  def self.authenticate_by_token(token)
    validity_days.find_by!(token:)
  end

  def current_user=(user)
    raise ActiveRecord::RecordNotFound unless user&.id

    update_column(:user_id, user.id) # rubocop:disable Rails/SkipsModelValidations
  end
end
