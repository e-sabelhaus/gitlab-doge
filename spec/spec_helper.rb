ENV['RAILS_ENV'] ||= 'test'

require 'fast_spec_helper'
require 'config/environment'
require 'rspec/rails'
require 'simplecov'

SimpleCov.start

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.before do
    DatabaseCleaner.clean
  end
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.include AuthenticationHelper
  config.include Features, type: :feature
  config.include HttpsHelper
  config.include OauthHelper
  config.include FactoryGirl::Syntax::Methods
  DatabaseCleaner.strategy = :deletion
end

Capybara.configure do |config|
  config.javascript_driver = :webkit
  config.default_wait_time = 4
end

OmniAuth.configure do |config|
  config.test_mode = true
end
