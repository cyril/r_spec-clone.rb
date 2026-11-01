# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

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

# spec/describe/dsl_described_class_spec.rb:8: Success: expected RSpec::Clone::Dsl to be RSpec::Clone::Dsl
# spec/describe/dsl_described_class_spec.rb:11: Success: expected Integer to be Integer
# spec/describe/dsl_described_class_spec.rb:17: Success: expected #<RSpec::Clone::Error::UndefinedDescribedClass: the first argument to at least one example group must be a module> to raise exception RSpec::Clone::Error::UndefinedDescribedClass
