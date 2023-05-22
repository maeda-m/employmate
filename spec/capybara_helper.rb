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
    viewport: { width: 750, height: 1334 }
  )

  if ENV['VIDEO']
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

def current_user
  current_session_store.user
end

def stub_delete_method_submit(visit_path)
  page.evaluate_script(<<~JAVASCRIPT)
    (() => {
      const form = document.createElement('form')
      form.method = 'post'
      form.action = "#{visit_path}"

      const methodDelete = document.createElement('input')
      methodDelete.type = 'hidden'
      methodDelete.name = '_method'
      methodDelete.value = 'delete'

      const button = document.createElement('button')
      button.type = 'submit'
      button.dataset.turbo = false
      button.append(document.createTextNode('疑似的にDELETEメソッド'))

      form.append(methodDelete)
      form.append(button)

      document.querySelector('body').append(form)
    })()
  JAVASCRIPT

  click_on('疑似的にDELETEメソッド')
end
