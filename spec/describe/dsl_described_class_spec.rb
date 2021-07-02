# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

# rubocop:disable RSpec/DescribedClass:
RSpec.describe "RSpec clone" do
  describe RSpec::Clone::Dsl do
    describe "#described_class" do
      it { expect(described_class).to be(RSpec::Clone::Dsl) }

      describe Integer do
        it { expect(described_class).to be(Integer) }
      end
    end
  end

  it "does not implement the method" do
    expect { described_class }.to raise_exception(::RSpec::Clone::Error::UndefinedDescribedClass)
  end
end
# rubocop:enable RSpec/DescribedClass:

# Success: expected to be RSpec::Clone::Dsl.
# Success: expected to be Integer.
# Success: the first argument to at least one example group must be a module.
