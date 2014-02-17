require "spec_helper"

describe "Readme Usage" do
  README_PATH = File.expand_path("../../../README.md", __FILE__)

  def self.extract_usage_rspec
    lines = File.read(README_PATH).lines.to_a
    lineno = lines.index { |line| line =~ /^```ruby/ } + 1
    length = lines[lineno, lines.length].index { |line| line =~ /^```/ }
    [ lines[lineno, length].join, README_PATH, lineno ]
  end

  instance_eval *extract_usage_rspec
end