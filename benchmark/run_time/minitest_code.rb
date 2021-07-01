# frozen_string_literal: true

require "minitest/autorun"

# A minitest spec with 1,000,000 expectations.
class Test < Minitest::Test
  1_000_000.times do |i|
    define_method("test_n#{i}") do
      refute_equal(true, false)
    end
  end
end
