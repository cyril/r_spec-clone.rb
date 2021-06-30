# frozen_string_literal: true

require "r_spec/clone"

# An RSpec clone spec with 1 expectation.
RSpec.describe "The true from the false" do
  it { expect(false).not_to be(true) }
end
