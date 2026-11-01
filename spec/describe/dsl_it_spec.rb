# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.describe RSpec::Clone::Dsl do
  describe ".describe" do
    it "takes a block" do
      expect { described_class.describe("without a block") }.to raise_exception ArgumentError
    end
  end

  describe ".context" do
    it "takes a block" do
      expect { described_class.context("without a block") }.to raise_exception ArgumentError
    end
  end

  describe ".it" do
    it "takes a block" do
      expect { described_class.it("without a block") }.to raise_exception ArgumentError
    end
  end

  describe ".its" do
    it "takes a block" do
      expect { described_class.its(:size) }.to raise_exception ArgumentError
    end

    it "takes a Symbol" do
      expect { described_class.its("size") { nil } }.to raise_exception ArgumentError
    end

    context "with keyword arguments" do
      subject { { a: 1 } }

      its(:fetch, :b) { is_expected.to raise_exception KeyError }
      its(:merge, b: 2) { is_expected.to eq({ a: 1, b: 2 }) }
    end
  end
end

# spec/describe/dsl_it_spec.rb:8: Success: expected #<ArgumentError: a block must be given> to raise exception ArgumentError
# spec/describe/dsl_it_spec.rb:14: Success: expected #<ArgumentError: a block must be given> to raise exception ArgumentError
# spec/describe/dsl_it_spec.rb:20: Success: expected #<ArgumentError: a block must be given> to raise exception ArgumentError
# spec/describe/dsl_it_spec.rb:26: Success: expected #<ArgumentError: a block must be given> to raise exception ArgumentError
# spec/describe/dsl_it_spec.rb:30: Success: expected #<ArgumentError: the name of the method must be a Symbol> to raise exception ArgumentError
# spec/describe/dsl_it_spec.rb:36: Success: expected #<KeyError: key not found: :b> to raise exception KeyError
# spec/describe/dsl_it_spec.rb:37: Success: expected {a: 1, b: 2} to eq {a: 1, b: 2}
