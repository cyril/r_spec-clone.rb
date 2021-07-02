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

# Success: expected to eq [1, 2, 3].
# Success: expected to eq [].
