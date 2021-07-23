# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe RSpec do
  context "when passing the actual value through an argument" do
    subject do
      ::RSpec.describe Integer do
        it { expect(4).to be 42 }
      end
    rescue ::SystemExit => e
      e.success?
    end

    it { is_expected.to be_false }
  end

  context "when passing the actual value through a block" do
    subject do
      ::RSpec.describe Integer do
        it { expect { 4 }.to be 42 }
      end
    rescue ::SystemExit => e
      e.success?
    end

    it { is_expected.to be_false }
  end

  context "when passing the actual value through its system" do
    subject do
      ::RSpec.describe Integer do
        subject { 4 }

        its(:itself) { is_expected.to be 42 }
      end
    rescue ::SystemExit => e
      e.success?
    end

    it { is_expected.to be_false }
  end
end

# Failure: expected 4 to be 42.
# spec/describe/example/raise_unless_passed_spec.rb:9
# Success: expected to be false.
# Failure: expected 4 to be 42.
# spec/describe/example/raise_unless_passed_spec.rb:21
# Success: expected to be false.
# Failure: expected 4 to be 42.
# spec/describe/example/raise_unless_passed_spec.rb:35
# Success: expected to be false.
