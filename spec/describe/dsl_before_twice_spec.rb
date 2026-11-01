# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.describe RSpec::Clone::Dsl do
  describe ".before" do
    before { @words = ["one"] }
    before { @words << "two" }

    it "runs each block, in the order of the group" do
      expect(@words).to eq %w[one two]
    end

    context "when nested" do
      before { @words << "three" }

      it { expect(@words).to eq %w[one two three] }
    end

    it "takes a block" do
      expect { described_class.before }.to raise_exception ArgumentError
    end
  end
end

# spec/describe/dsl_before_twice_spec.rb:11: Success: expected ["one", "two"] to eq ["one", "two"]
# spec/describe/dsl_before_twice_spec.rb:17: Success: expected ["one", "two", "three"] to eq ["one", "two", "three"]
# spec/describe/dsl_before_twice_spec.rb:21: Success: expected #<ArgumentError: a block must be given> to raise exception ArgumentError
