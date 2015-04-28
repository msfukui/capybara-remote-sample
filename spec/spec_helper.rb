require 'capybara/rspec'
require 'selenium-webdriver'

RSpec.configure do |config|
  config.include Capybara::DSL
end

host = '192.168.11.3'
port = '4444'

Capybara.register_driver :remote_windows do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: "http://#{host}:#{port}/wd/hub/",
    desired_capabilities: :firefox
  )
end

Capybara.default_driver = :remote_windows

Capybara.app_host = 'http://www.biglobe.ne.jp'
