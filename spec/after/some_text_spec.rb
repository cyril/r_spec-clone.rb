# frozen_string_literal: true

require_relative File.join("..", "spec_helper")
require 'tempfile'

RSpec.describe Tempfile do
  before do
    print "Hello, "
  end

  after do
    puts "bye!"
  end

  context "with a context" do
    before do
      puts "Bob!"
    end

    after do
      print "Bye "
    end

    it { puts "How are you?" }
  end
end

# Output to the console
#   Hello, Bob!
#   How are you?
#   Bye bye!
