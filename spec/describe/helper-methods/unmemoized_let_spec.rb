# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

$count = 0

RSpec.describe Integer do
  let(:count) { $count += 1 }

  it "is not cached per example" do
    expect(count).to be(1)
    expect(count).to be(2)
  end

  it "is reset to the original value" do
    expect(count).to be(1)
  end
end
