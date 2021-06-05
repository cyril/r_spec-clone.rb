# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

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
end
