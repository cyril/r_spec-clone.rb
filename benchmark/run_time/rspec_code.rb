# frozen_string_literal: true

require "rspec/autorun"

# An RSpec spec with 10 000 expectations.
RSpec.describe "The true from the false" do
  10_000.times do
    it { expect(false).not_to be(true) }
  end
end
