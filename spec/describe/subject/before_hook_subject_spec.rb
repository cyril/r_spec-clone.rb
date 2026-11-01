# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe Array do
  context "with memoized subject helper" do
    subject do
      @subject ||= []
    end

    before { subject.push(1, 2, 3) }

    it "keeps returning the subject content" do
      expect(subject).to eq([1, 2, 3])
    end
  end

  context "without memoized subject helper" do
    subject do
      []
    end

    before { subject.push(1, 2, 3) }

    it "keeps returning the subject content" do
      expect(subject).to eq([])
    end
  end
end

# spec/describe/subject/before_hook_subject_spec.rb:14: Success: expected [1, 2, 3] to eq [1, 2, 3]
# spec/describe/subject/before_hook_subject_spec.rb:26: Success: expected [] to eq []
