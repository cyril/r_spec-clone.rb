# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe Integer do
  it "raises a no method error" do
    expect { described_class.new }.to raise_exception ::NoMethodError
  end

  describe "#/" do
    subject { 84 }

    context "when dividing by zero" do
      let(:divisor) { 0 }

      it "expects an exception to be raised" do
        expect { subject / divisor }.to raise_exception ::ZeroDivisionError
      end
    end

    context "when not dividing by zero" do
      let(:divisor) { 2 }

      it "does not expect an exception to be raised" do
        expect { subject / divisor }.not_to raise_exception ::ZeroDivisionError
      end
    end
  end
end

# Success: undefined method `new' for Integer:Class.
# Success: divided by 0.
# Success: expected 42 not to raise exception ZeroDivisionError.
