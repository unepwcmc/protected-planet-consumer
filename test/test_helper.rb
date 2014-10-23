
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
ActiveRecord::Migration.maintain_test_schema!
require 'webmock/minitest'


class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
end


