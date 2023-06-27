require 'debug'
require 'capybara/rspec'

Capybara.register_driver(:playwright) do |app|
  driver = Capybara::Playwright::Driver.new(
    app,
    playwright_cli_executable_path: './node_modules/.bin/playwright',
    browser_type: :chromium,
    headless: true,
    # See: https://playwright.dev/docs/emulation#locale--timezone
    locale: 'ja-JP',
    viewport: { width: 375, height: 667 }
  )

  if ENV['VIDEO']
    FileUtils.mkdir_p(Capybara.save_path)
    driver.on_save_screenrecord do |video_path|
      FileUtils.mv(video_path, Capybara.save_path.join(File.basename(video_path)))
    end
  end

  driver
end

Capybara.configure do |config|
  config.default_driver = :playwright
  config.javascript_driver = :playwright
  config.default_max_wait_time = 5
  config.save_path = 'tmp/capybara'

  config.server = :puma
  config.server_host = 'localhost'
  config.server_port = 8181
  config.raise_server_errors = false
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

def current_session_store
  Session.find_by!(session_id: session_private_id_from_cookie_value)
end

def current_session_user
  current_session_store.user
end
