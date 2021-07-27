# frozen_string_literal: true

require "fix"

# A Fix spec with 100,000 expectations.
set = Fix do
  100_000.times do
    it MUST be true
  end
end

set.test { true }
