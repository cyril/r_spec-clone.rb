# frozen_string_literal: true

require "rspec/autorun"

# An RSpec spec with 1,000,000 expectations.
RSpec.describe "The true from the false" do
  1_000_000.times do
    it { expect(false).not_to be(true) }
  end
end
