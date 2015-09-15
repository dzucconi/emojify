require 'rubygems'

ENV['RACK_ENV'] ||= 'test'

require 'rack/test'
require 'sinatra'

require File.expand_path('../../application', __FILE__)

RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec
  config.raise_errors_for_deprecations!
end
