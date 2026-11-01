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

# spec/describe/helper-methods/let_arguments_spec.rb:16: Success: expected 8 to be 8
# spec/describe/helper-methods/let_arguments_spec.rb:24: Success: expected 42 to be 42
