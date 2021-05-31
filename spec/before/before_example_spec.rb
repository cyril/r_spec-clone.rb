# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.describe Array do
  before do
    @elements = []
  end

  describe "initialized in before" do
    it "has 0 elements" do
      expect(@elements.count).to be(0)
    end

    context "when a new element is added" do
      before do
        @elements << 1
      end

      it "has 1 element" do
        expect(@elements.count).to be(1)
      end
    end
  end
end
