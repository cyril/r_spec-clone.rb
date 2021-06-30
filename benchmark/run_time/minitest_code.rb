# frozen_string_literal: true

require "minitest/autorun"

# A minitest spec with 10 000 expectations.
class Test < Minitest::Test
  10_000.times do |i|
    define_method("test_n#{i}") do
      refute_equal(false, true)
    end
  end
end
