# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.describe RSpec::Clone::Dsl do
  describe ".after" do
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
end

# Hello, Bob!
# How are you?
# Bye bye!
