# frozen_string_literal: true

require "rubygems"
require "bundler/setup"
require "pry"

ENV["RAILS_ENV"] = "test"

require_relative "dummy/config/environment"

require "rails/all"
# require "rspec/rails"

require "rails/plugin/test"

Dir[Rails.root.join("spec/support/**/*.rb")].sort.each { |f| require f }

ActiveRecord::Migrator.migrations_paths = [File.expand_path("../spec/dummy/db/migrate", __dir__)]

require "rails/test_help"

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("fixtures", __dir__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = "#{ActiveSupport::TestCase.fixture_path}/files"
  ActiveSupport::TestCase.fixtures :all
end

require "lock"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # config.shared_context_metadata_behavior = :apply_to_host_groups
  # config.filter_run_when_matching :focus
end

def copy_password_template_file
  FileUtils.copy("#{File.dirname(__FILE__)}/resources/lock_password", "#{Rails.root}/config/lock_password")
end

def delete_lockdown_file
  FileUtils.rm("#{Rails.root}/config/lock_password") if File.exist? "#{Rails.root}/config/lock_password"
end
