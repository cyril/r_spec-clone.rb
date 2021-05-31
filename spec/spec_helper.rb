# frozen_string_literal: true

require "simplecov"
SimpleCov.command_name "RSpec clone"
SimpleCov.start

require_relative File.join("..", "lib", "r_spec")
