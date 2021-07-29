# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#be_within" do
  it { expect(40).to be_within(2).of(42) }
  it { expect(39).not_to be_within(2).of(42) }
end

# Success: expected 40 to be within 2 of 42.
# Success: expected 39 not to be within 2 of 42.
