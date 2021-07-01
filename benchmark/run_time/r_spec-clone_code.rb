# frozen_string_literal: true

require "r_spec/clone"

# An RSpec clone spec with 1,000,000 expectations.
RSpec.describe "The true from the false" do
  1_000_000.times do
    it { expect(false).not_to be(true) }
  end
end
