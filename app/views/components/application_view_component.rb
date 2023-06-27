# frozen_string_literal: true

class ApplicationViewComponent < ViewComponentContrib::Base
  include Turbo::FramesHelper
  include ApplicationHelper
end
