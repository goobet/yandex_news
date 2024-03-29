require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort('The Rails in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'support/webmock'
require 'support/simplecov'
require 'fakeredis/rspec'

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
