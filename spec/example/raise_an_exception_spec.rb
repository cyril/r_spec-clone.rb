# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.describe Integer do
  subject { 84 }

  describe "#/" do
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
