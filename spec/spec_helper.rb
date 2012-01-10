require 'bundler/setup'

require 'simplecov'
SimpleCov.start

require 'betamax'

RSpec.configure do |config|
  config.include Betamax::TestHelpers
end
