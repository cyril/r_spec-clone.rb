# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.describe Integer do
  before do
    @value = 123
  end

  describe "nested" do
    it "access state set in before" do
      expect(@value).to be(123)
    end

    describe "nested more deeply" do
      it "access state set in before" do
        expect(@value).to be(123)
      end
    end
  end

  describe "nested in parallel" do
    it "access state set in before" do
      expect(@value).to be(123)
    end
  end
end
