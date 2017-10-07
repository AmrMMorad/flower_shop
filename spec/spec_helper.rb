ENV['RACK_ENV'] = 'test'

require 'bundler/setup'
require 'flower_shop'
require 'coveralls'
require 'boot'

Coveralls.wear!

RSpec.configure do |config|
  config.order = :random

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
