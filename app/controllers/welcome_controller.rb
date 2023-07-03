# frozen_string_literal: true

class WelcomeController < ApplicationController
  skip_before_action :require_registered_user, only: %i[index terms_of_service privacy_policy robots]
  before_action :require_not_registered_user, except: %i[terms_of_service privacy_policy robots]

  def index
  end

  def terms_of_service
    @page_title = '利用規約'
  end

  def privacy_policy
    @page_title = 'プライバシーポリシー'
  end

  def robots
    @disallowed_path = '/' unless ENV['ROBOTS_INDEX']
  end
end
