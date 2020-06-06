$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
$LOAD_PATH << File.join(File.dirname(__FILE__))

require "simplecov"
require "rspec/simplecov"

SimpleCov.start { add_filter "/spec|_spec/" }
RSpec::SimpleCov.start

require "awesome_print"
require "bundler/setup"
require "bumblebee"

require 'support/fixtures_helper'


Dir["./support/*.rb"].to_a.each do |f|
  require File.expand_path(f)
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  #config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def capture_stdout(&block)
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end
