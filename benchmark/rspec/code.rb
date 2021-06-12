# frozen_string_literal: true

require "rspec"

# An RSpec spec with 1 expectation.
RSpec.describe do
  it { expect(false).not_to be(true) }
end
