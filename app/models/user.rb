# frozen_string_literal: true

class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :sessions, dependent: :destroy
  has_many :tasks, dependent: :destroy

  validates :google_id, uniqueness: true, allow_nil: true # rubocop:disable Rails/UniqueValidationWithoutIndex

  def self.find_by_hash_google_id(google_id)
    hash = Digest::SHA512.hexdigest(google_id)

    find_by(google_id: hash)
  end

  def register(google_id)
    hash = Digest::SHA512.hexdigest(google_id)

    update!(google_id: hash)
  end

  def registered?
    !!google_id
  end
end
