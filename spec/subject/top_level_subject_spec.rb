# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.describe Array do
  subject { [1, 2, 3] }

  it "has the prescribed elements" do
    expect(subject).to eq([1, 2, 3])
  end
end
