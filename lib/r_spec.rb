# frozen_string_literal: true

require_relative File.join("r_spec", "dsl")

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
#   #   Success: expected true to be true.
#   #   Success: expected false to be false.
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
  # Specs are built with this method.
  #
  # @param const [Module, String] A module to include in block context.
  # @param block [Proc] The block to define the specs.
  #
  # @api public
  def self.describe(const, &block)
    Dsl.describe(const, &block)
  end

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
  # It is usually used inside a {Dsl.describe} or {Dsl.context} section.
  #
  # @param name [String, nil] The name of the spec.
  # @param block [Proc] An expectation to evaluate.
  #
  # @raise (see RSpec::ExpectationTarget::Base#result)
  # @return (see RSpec::ExpectationTarget::Base#result)
  def self.it(name = nil, &block)
    Dsl.it(name, &block)
  end
end
