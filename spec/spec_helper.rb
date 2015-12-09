require 'simplecov'
require 'dm-rspec'

SimpleCov.start

RSpec.configure do |config|
  # Redirect STDOUT and STDERR to /dev/NULL as per:
  # http://stackoverflow.com/questions/15430551/suppress-console-output-during-rspec-tests
  original_stderr = $stderr
  original_stdout = $stdout
  config.before(:all) do
    # Redirect stderr and stdout
    $stderr = File.open(File::NULL, "w")
    $stdout = File.open(File::NULL, "w")
  end
  config.after(:all) do
    $stderr = original_stderr
    $stdout = original_stdout
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include(DataMapper::Matchers)
end
