# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe Array do
  subject { [1, 2, 3] }

  it "has the prescribed elements" do
    expect(subject).to eq([1, 2, 3])
  end
end

# spec/describe/subject/top_level_subject_spec.rb:9: Success: expected [1, 2, 3] to eq [1, 2, 3]
