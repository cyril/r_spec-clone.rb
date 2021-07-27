# frozen_string_literal: true

require "minitest/autorun"

# A minitest spec with 1 expectation.
class Test < Minitest::Test
  def test_true
    assert_equal(true, true)
  end
end
