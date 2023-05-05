require 'debug'
require 'capybara/rspec'

Capybara.register_driver(:playwright) do |app|
  Capybara::Playwright::Driver.new(
    app,
    playwright_cli_executable_path: './node_modules/.bin/playwright',
    browser_type: :chromium,
    headless: true,
    # See: https://playwright.dev/docs/emulation#locale--timezone
    locale: 'ja-JP',
    viewport: { width: 750, height: 1334 }
  )
end

Capybara.configure do |config|
  config.default_driver = :playwright
  config.javascript_driver = :playwright
  config.default_max_wait_time = 5
  config.save_path = 'tmp/capybara'

  config.server = :puma
  config.server_host = 'localhost'
  config.server_port = 8181
end

def session_private_id_from_cookie_value
  session_private_id = nil
  page.driver.with_playwright_page do |playwright|
    cookie_value = playwright.context.cookies.find { |cookie| cookie['name'] == '_employmate_session' }['value']
    # See: https://github.com/rack/rack-session/blob/main/lib/rack/session/abstract/id.rb#L30-L32
    session_private_id = Rack::Session::SessionId.new(cookie_value).private_id
  end

  session_private_id
end
