# frozen_string_literal: true

require "minitest/autorun"

# A minitest spec with 100,000 expectations.
class Test < Minitest::Test
  100_000.times do |i|
    define_method("test#{i}") do
      assert_equal(true, true)
    end
  end
end
