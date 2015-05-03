require 'capybara/rspec'
require 'selenium-webdriver'

Dir[Pathname(Dir.pwd).join('spec/supports/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include Capybara::DSL
end

EXECUTABLE_BROWSERS = ['ie','internet_explorer','chrome','firefox','safari']
webbrowser = ENV['RUN_REMOTE_BROWSER'] || 'firefox'
webbrowser = 'firefox' unless EXECUTABLE_BROWSERS.include?(webbrowser)

host = ENV['RUN_REMOTE_HOST'] || '127.0.0.1'
port = ENV['RUN_REMOTE_PORT'] || '4444'

Capybara.register_driver :remote_server do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: "http://#{host}:#{port}/wd/hub/",
    desired_capabilities: webbrowser.to_sym
  )
end

Capybara.default_driver = :remote_server

Capybara.ignore_hidden_elements = true

Capybara.default_wait_time = 15

Capybara.app_host = 'http://www.google.co.jp'
