# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.describe Integer do
  let(:answer) { 42 }

  it "returns the value" do
    expect(answer).to be(42)
  end

  context "when the number is incremented" do
    let(:answer) { super().next }

    it "returns the next value" do
      expect(answer).to be(43)
    end
  end
end
