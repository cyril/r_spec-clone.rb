# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe Integer do
  subject do
    add_one(value)
  end

  let(:add_one, &:next)

  context "when the value is 7" do
    let(:value) { 7 }

    it "returns the next value" do
      expect(subject).to be(8)
    end
  end

  context "when the value is 41" do
    let(:value) { 41 }

    it "returns the next value" do
      expect(subject).to be(42)
    end
  end
end

# Success: expected to be 8.
# Success: expected to be 42.
