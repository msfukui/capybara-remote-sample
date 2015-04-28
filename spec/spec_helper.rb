require 'capybara/rspec'
require 'selenium-webdriver'

RSpec.configure do |config|
  config.include Capybara::DSL
end

EXECUTABLE_BROWSERS = ['ie', 'internet_explorer', 'chrome', 'firefox']
webbrowser = ENV['EXECUTE_BROWSER'] || 'firefox'
webbrowser = 'firefox' unless EXECUTABLE_BROWSERS.include?(webbrowser)

host = ENV['EXECUTE_HOST'] || '192.168.11.3'
port = ENV['EXECUTE_PORT'] || '4444'

Capybara.register_driver :remote_windows do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: "http://#{host}:#{port}/wd/hub/",
    desired_capabilities: webbrowser.to_sym
  )
end

Capybara.default_driver = :remote_windows

Capybara.ignore_hidden_elements = true

Capybara.default_wait_time = 15

Capybara.app_host = 'http://www.biglobe.ne.jp'
