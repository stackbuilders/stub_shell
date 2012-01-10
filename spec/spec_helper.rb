require 'bundler/setup'
require 'betamax'

RSpec.configure do |config|
  config.include Betamax::TestHelpers
end
