# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.describe RSpec::Clone::Dsl do
  describe ".let" do
    it "keeps the name of the hook for before" do
      expect { described_class.let(:initialize) { nil } }.to raise_exception RSpec::Clone::Error::ReservedMethod
    end

    it "takes the name as a String too" do
      expect { described_class.let("initialize") { nil } }.to raise_exception RSpec::Clone::Error::ReservedMethod
    end

    it "keeps the words of an example" do
      expect { described_class.let(:expect) { nil } }.to raise_exception RSpec::Clone::Error::ReservedMethod
    end

    it "keeps the word of an its example" do
      expect { described_class.let(:is_expected) { nil } }.to raise_exception RSpec::Clone::Error::ReservedMethod
    end

    it "keeps the matchers" do
      expect { described_class.let(:eq) { nil } }.to raise_exception RSpec::Clone::Error::ReservedMethod
    end

    it "keeps the private words too" do
      expect { described_class.let(:method_missing) { nil } }.to raise_exception RSpec::Clone::Error::ReservedMethod
    end

    it "leaves any other name" do
      expect(described_class.let(:method) { nil }).to be :method
    end
  end
end

# spec/describe/dsl_let_spec.rb:8: Success: expected #<RSpec::Clone::Error::ReservedMethod: initialize is reserved> to raise exception RSpec::Clone::Error::ReservedMethod
# spec/describe/dsl_let_spec.rb:12: Success: expected #<RSpec::Clone::Error::ReservedMethod: initialize is reserved> to raise exception RSpec::Clone::Error::ReservedMethod
# spec/describe/dsl_let_spec.rb:16: Success: expected #<RSpec::Clone::Error::ReservedMethod: expect is reserved> to raise exception RSpec::Clone::Error::ReservedMethod
# spec/describe/dsl_let_spec.rb:20: Success: expected #<RSpec::Clone::Error::ReservedMethod: is_expected is reserved> to raise exception RSpec::Clone::Error::ReservedMethod
# spec/describe/dsl_let_spec.rb:24: Success: expected #<RSpec::Clone::Error::ReservedMethod: eq is reserved> to raise exception RSpec::Clone::Error::ReservedMethod
# spec/describe/dsl_let_spec.rb:28: Success: expected #<RSpec::Clone::Error::ReservedMethod: method_missing is reserved> to raise exception RSpec::Clone::Error::ReservedMethod
# spec/describe/dsl_let_spec.rb:32: Success: expected :method to be :method
