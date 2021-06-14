# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

# rubocop:disable RSpec/DescribedClass:
RSpec.describe "RSpec clone" do
  describe RSpec::Dsl do
    describe "#described_class" do
      it { expect(described_class).to be(RSpec::Dsl) }

      describe Integer do
        it { expect(described_class).to be(Integer) }
      end
    end
  end

  it "does not implement the method" do
    expect { described_class }.to raise_exception(::RSpec::Error::UndefinedDescribedClass)
  end
end
# rubocop:enable RSpec/DescribedClass:
