if ENV["CODECLIMATE_REPO_TOKEN"]
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
else
  require 'simplecov'
  SimpleCov.start("test_frameworks")
end

require "rspec"
require "pry-nav"
require "rspec-do_action"

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true if RSpec::Version::STRING =~ /^2/
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end
