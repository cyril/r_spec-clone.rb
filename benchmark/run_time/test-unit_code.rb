# frozen_string_literal: true

require "test/unit"

# A test-unit spec with 1,000,000 expectations.
class TestMethod < Test::Unit::TestCase
  1_000_000.times do |i|
    define_method("test_n#{i}") do
      refute_equal(true, false)
    end
  end
end
