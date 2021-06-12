# frozen_string_literal: true

require "r_spec"

# An RSpec clone spec with 1 expectation.
RSpec.describe do
  it { expect(false).not_to be(true) }
end
