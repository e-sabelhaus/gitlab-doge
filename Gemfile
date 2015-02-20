source "https://rubygems.org"

ruby "2.1.5"

gem "active_model_serializers"
gem 'activerecord-session_store', github: 'rails/activerecord-session_store'
gem "angularjs-rails"
gem "attr_extras"
gem "bourbon"
gem "coffee-rails"
gem "coffeelint"
gem "font-awesome-rails"
gem "haml-rails"
gem "high_voltage"
gem "jquery-rails"
gem "jshintrb"
#This is here in the event your exernal gitlab db is mysql
gem "mysql2"
gem "neat"
gem "newrelic_rpm"
gem "gitlab", "3.2.0"
gem "omniauth"
gem "omniauth-dice", "~> 0.1"
gem "paranoia", "~> 2.0"
gem "pg"
gem "rb-readline"
gem "rails", "4.1.5"
gem "sinatra"
gem "sidekiq"
gem "sidekiq-failures"
gem "rubocop", "0.29.1"
gem "sass-rails", "~> 4.0.2"
gem "uglifier", ">= 1.0.3"
gem "unicorn"
gem "dotenv-rails"

group :staging, :production do
  gem "rails_12factor"
end

group :development, :test do
  gem "awesome_print"
  gem "byebug"
  gem "foreman"
  gem "konacha"
  gem "poltergeist"
  gem "rspec-rails", ">= 2.14"
  gem "quiet_assets"
  gem "pry"
  gem "pry-rails"
  gem "web-console"
  gem "thin"
end

group :test do
  gem "capybara", "~> 2.4.0"
  gem "capybara-webkit"
  gem "database_cleaner"
  gem "factory_girl_rails"
  gem "launchy"
  gem "shoulda-matchers"
  gem "webmock"
  gem "codeclimate-test-reporter"
  gem "rspec-sidekiq"
  gem "sentry-raven"
end
