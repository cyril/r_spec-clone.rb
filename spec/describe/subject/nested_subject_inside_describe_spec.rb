# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe Array do
  subject { [1, 2, 3] }

  describe "has some elements" do
    it "has the prescribed elements" do
      expect(subject).to eq([1, 2, 3])
    end
  end
end

# spec/describe/subject/nested_subject_inside_describe_spec.rb:10: Success: expected [1, 2, 3] to eq [1, 2, 3]
