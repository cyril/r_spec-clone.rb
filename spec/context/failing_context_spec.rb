# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.describe RSpec::Clone::Dsl do
  describe ".context" do
    subject do
      ::RSpec.context "when an expectation is not met" do
        it { expect(4).to be 42 }
      end
    rescue ::SystemExit => e
      e.success?
    end

    it "exits with the status of the child" do
      expect(subject).to be_false
    end
  end
end

# spec/context/failing_context_spec.rb:9: Failure: expected 4 to be 42
# spec/context/failing_context_spec.rb:16: Success: expected false to be false
