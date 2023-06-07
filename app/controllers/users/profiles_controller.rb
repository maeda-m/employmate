# frozen_string_literal: true

class Users::ProfilesController < ApplicationController
  before_action :require_not_registered_user
  before_action :require_anonymous_user

  def show
    @page_title = "あなたの状況や希望に合う雇用保険制度は#{Current.user.recommend}です。"
  end
end
