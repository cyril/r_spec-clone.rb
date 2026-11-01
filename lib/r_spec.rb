# frozen_string_literal: true

require_relative File.join("r_spec", "clone", "dsl")

# The namespace of RSpec, which the clone takes for its words: `describe`,
# `context`, `it` and `pending`, at the top level of a spec file.
#
# @example
#   require "r_spec"
#
#   RSpec.describe Array do
#     describe "#size" do
#       it "reports the number of elements" do
#         expect([1, 2, 3].size).to eq 3
#       end
#     end
#
#     describe "#empty?" do
#       it "is true when the array holds nothing" do
#         expect([].empty?).to be_true
#       end
#     end
#   end
#
#   # spec/array_spec.rb:6: Success: expected 3 to eq 3
#   # spec/array_spec.rb:12: Success: expected true to be true
#
# @api public
module RSpec
  # Defines an example group that establishes a context, like _empty array_
  # versus _array with elements_, and runs it in a child process.
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
  #   # spec/zero_spec.rb:6: Success: expected #<ZeroDivisionError: divided by 0> to raise exception ZeroDivisionError
  #
  # @param description [String] a description, usually beginning with "when",
  #   "with" or "without"
  # @yield the specs of the context
  # @return [nil]
  # @raise [ArgumentError] without a block
  # @raise [NotImplementedError] when this Ruby cannot fork
  # @raise [SystemExit] when a spec of the context did not succeed
  def self.context(description, &)
    Clone::Dsl.context(description, &)
  end

  # Defines an example group that describes a unit to be tested.
  #
  # @example
  #   require "r_spec"
  #
  #   RSpec.describe String do
  #     it { expect(described_class).to be String }
  #   end
  #
  #   # spec/string_spec.rb:4: Success: expected String to be String
  #
  # @param const [Module, String] the module under test, or a description
  # @yield the specs of the group
  # @return [nil]
  # @raise [ArgumentError] without a block
  def self.describe(const, &)
    Clone::Dsl.describe(const, &)
  end

  # Defines a concrete test case.
  #
  # @example
  #   require "r_spec"
  #
  #   RSpec.it { expect(41.next).to be 42 }
  #
  #   # spec/next_spec.rb:3: Success: expected 42 to be 42
  #
  # @param name [String, nil] the name of the example
  # @yield the example, with its expectations
  # @return [nil]
  # @raise [ArgumentError] without a block
  # @raise [SystemExit] when an expectation is not met
  def self.it(name = nil, &)
    Clone::Dsl.it(name, &)
  end

  # Defines a pending test case: its block, if any, is never run.
  #
  # @example
  #   require "r_spec"
  #
  #   RSpec.pending "is not yet implemented"
  #
  #   # spec/later_spec.rb:3: Pending: is not yet implemented
  #
  # @param message [String] why the example is pending
  # @yield never: the block is not run
  # @return [nil]
  def self.pending(message, &)
    Clone::Dsl.pending(message, &)
  end
end
