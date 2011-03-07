require 'rubygems'
ENV["RAILS_ENV"] ||= "test_cuc"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'cucumber/formatter/unicode' # Remove this line if you don't want Cucumber Unicode support
require 'cucumber/rails/rspec'
require 'cucumber/rails/world'
require 'cucumber/rails/active_record'
require 'cucumber/web/tableish'
require 'capybara/rails'
require 'capybara/cucumber'
require 'capybara/session'
require "selenium-webdriver"

Capybara.default_selector = :css
ActionController::Base.allow_rescue = false
Cucumber::Rails::World.use_transactional_fixtures = true

if defined?(ActiveRecord::Base)
  begin
    require 'database_cleaner'
    DatabaseCleaner.strategy = :truncation
  rescue LoadError => ignore_if_database_cleaner_not_present
  end
end
