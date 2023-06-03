module Employmate
  def config
    Rails.configuration.x.employmate
  end
  module_function :config
end

Employmate.config.google_client_id = ENV['GOOGLE_OPENID_CONNECT_CLIENT_ID'].presence
Employmate.config.google_measurement_id = ENV['GOOGLE_ANALYTICS_MEASUREMENT_ID'].presence
