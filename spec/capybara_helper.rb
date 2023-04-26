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
