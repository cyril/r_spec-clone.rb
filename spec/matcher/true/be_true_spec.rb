# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#be_true" do
  it { expect(true).to be_true }
  it { expect(false).not_to be_true }
end

# Success: expected to be true.
# Success: expected false not to be true.
