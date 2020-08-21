# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.1"

gem "config", "~> 2.2"
gem "grape"
gem "grape-jwt-authentication"
gem "grape_logging"
gem "grape-swagger"
gem "json"
gem "jwt"
gem "mail"
gem "multi_json"
gem "rack"
gem "rack-cors"

group :development, :test do
  gem "airborne"
  gem "byebug"
  gem "racksh"
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails_config", require: false
end

group :development do
  gem "brakeman"
  gem "guard"
  gem "guard-minitest"
  gem "guard-rack"
  gem "guard-rubocop"
  gem "rake"
end

group :test do
  gem "minitest"
  gem "mocha"
  gem "rack-test", require: "rack/test"
  gem "simplecov", require: false
end
