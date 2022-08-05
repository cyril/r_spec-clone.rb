# frozen_string_literal: true

require "simplecov"
SimpleCov.command_name "RSpec clone"
SimpleCov.start do
  add_filter "/spec/"
end

require_relative File.join("..", "lib", "r_spec", "clone")
