# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.describe Array do
  subject { [1, 2, 3] }

  context "when inherited" do
    subject { super() + [4, 5, 6] }

    it "returns all the elements" do
      expect(subject).to eq([1, 2, 3, 4, 5, 6])
    end
  end
end
