# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

$count = 0

RSpec.describe Integer do
  let(:count) { $count += 1 }

  it "returns the value" do
    expect(count).to be(1)
  end

  it "is not cached across examples" do
    expect(count).to be(2)
  end
end
