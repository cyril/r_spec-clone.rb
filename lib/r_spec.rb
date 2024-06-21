# frozen_string_literal: true

require_relative File.join("r_spec", "clone", "dsl")

# Top level namespace for the RSpec clone.
#
# @example The true from the false
#   require "r_spec"
#
#   RSpec.describe "The true from the false" do
#     it { expect(false).not_to be true }
#   end
#
#   # Output to the console
#   #   Success: expected false not to be true.
#
# @example The basic behavior of arrays
#   require "r_spec"
#
#   RSpec.describe Array do
#     describe "#size" do
#       it "correctly reports the number of elements in the Array" do
#         expect([1, 2, 3].size).to eq 3
#       end
#     end
#
#     describe "#empty?" do
#       it "is empty when no elements are in the array" do
#         expect([].empty?).to be_true
#       end
#
#       it "is not empty if there are elements in the array" do
#         expect([1].empty?).to be_false
#       end
#     end
#   end
#
#   # Output to the console
#   #   Success: expected to eq 3.
#   #   Success: expected to be true.
#   #   Success: expected to be false.
#
# @example An inherited definition of let
#   require "r_spec"
#
#   RSpec.describe Integer do
#     let(:answer) { 42 }
#
#     it "returns the value" do
#       expect(answer).to be(42)
#     end
#
#     context "when the number is incremented" do
#       let(:answer) { super().next }
#
#       it "returns the next value" do
#         expect(answer).to be(43)
#       end
#     end
#   end
#
#   # Output to the console
#   #   Success: expected to be 42.
#   #   Success: expected to be 43.
#
# @api public
module RSpec
  # Defines an example group that establishes a specific context, like _empty
  # array_ versus _array with elements_.
  #
  # @example
  #   require "r_spec"
  #
  #   RSpec.context "when divided by zero" do
  #     subject { 42 / 0 }
  #
  #     it { is_expected.to raise_exception ZeroDivisionError }
  #   end
  #
  #   # Output to the console
  #   #   Success: divided by 0.
  #
  # @param description [String] A description that usually begins with "when",
  #   "with" or "without".
  # @param block [Proc] The block to define the specs.
  def self.context(description, &)
    Clone::Dsl.context(description, &)
  end

  # :nocov:

  # Defines an example group that describes a unit to be tested.
  #
  # @example
  #   require "r_spec"
  #
  #   RSpec.describe String do
  #     it { expect(described_class).to be String }
  #   end
  #
  #   # Output to the console
  #   #   Success: expected to be String.
  #
  # @example
  #   require "r_spec"
  #
  #   RSpec.describe String do
  #     let(:foo) { "foo" }
  #
  #     describe "+" do
  #       it("concats") { expect(foo + "bar").to eq "foobar" }
  #     end
  #   end
  #
  #   # Output to the console
  #   #   Success: expected to eq "foobar".
  #
  # @param const [Module, String] A module to include in block context.
  # @param block [Proc] The block to define the specs.
  def self.describe(const, &)
    Clone::Dsl.describe(const, &)
  end

  # :nocov:

  # Defines a concrete test case.
  #
  # The test is performed by the block supplied to &block.
  #
  # @example The integer after 41
  #   require "r_spec"
  #
  #   RSpec.it { expect(41.next).to be 42 }
  #
  #   # Output to the console
  #   #   Success: expected to be 42.
  #
  # It is usually used inside a {Clone::Dsl.describe} or {Clone::Dsl.context}
  # section.
  #
  # @param name [String, nil] The name of the spec.
  # @param block [Proc] An expectation to evaluate.
  #
  # @raise (see RSpec::Clone::ExpectationTarget::Base#result)
  # @return (see RSpec::Clone::ExpectationTarget::Base#result)
  def self.it(name = nil, &)
    Clone::Dsl.it(name, &)
  end

  # :nocov:

  # Defines a pending test case.
  #
  # `&block` is never evaluated. It can be used to describe behaviour that is
  # not yet implemented.
  #
  # @example
  #   require "r_spec"
  #
  #   RSpec.pending "is implemented but waiting" do
  #     expect something to be finished
  #   end
  #
  #   RSpec.pending "is not yet implemented and waiting"
  #
  #   # Output to the console
  #   #   Warning: is implemented but waiting.
  #   #   Warning: is not yet implemented and waiting.
  #
  # It is usually used inside a {Clone::Dsl.describe} or {Clone::Dsl.context}
  # section.
  #
  # @param message [String] The reason why the example is pending.
  #
  # @return [nil] Write a message to STDOUT.
  def self.pending(message)
    Clone::Dsl.pending(message)
  end
end
