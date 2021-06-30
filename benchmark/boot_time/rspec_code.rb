# frozen_string_literal: true

require "rspec/autorun"

# An RSpec spec with 1 expectation.
RSpec.describe "The true from the false" do
  it { expect(false).not_to be(true) }
end
