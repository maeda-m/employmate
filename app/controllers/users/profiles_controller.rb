# frozen_string_literal: true

class Users::ProfilesController < ApplicationController
  skip_before_action :require_registered_user, only: :show
  before_action :require_not_registered_user
  before_action :require_anonymous_user

  def show
    @page_title = 'あなたの状況や希望に合う雇用保険制度'
  end
end
