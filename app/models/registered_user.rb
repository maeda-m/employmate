# frozen_string_literal: true

class RegisteredUser
  def self.create!(user, authenticated_google_id)
    raise ArgumentError, user unless user&.anonymous?

    # NOTE: 匿名ユーザー時のセッションが悪用されないように削除する
    user.sessions.each(&:destory!)

    user.register(authenticated_google_id)
    user.create_tasks

    user
  end
end
