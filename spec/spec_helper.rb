require 'bundler/setup'

require 'simplecov'
SimpleCov.start

require 'stub_shell'

RSpec.configure do |config|
  config.include StubShell::TestHelpers
end
