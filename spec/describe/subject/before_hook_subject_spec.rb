# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe Array do
  subject { [] }

  before { subject.push(1, 2, 3) }

  it "keeps returning the subject content" do
    expect(subject).to eq([])
  end
end
