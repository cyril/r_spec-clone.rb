# frozen_string_literal: true

require 'matchi/rspec'
require 'fix/expect'

# Namespace for the RSpec framework.
#
# @api public
#
module RSpec
  # Specs are built with this method.
  #
  # @example The answer must be equal to 42.
  #   describe('the answer') do
  #     it { expect(42).to be 42 }
  #   end
  #
  # @param front_object [#object_id]  The front object.
  # @param options      [Hash]        Some options.
  # @param specs        [Proc]        The set of specs.
  #
  # @raise [SystemExit] The result of the test.
  def self.describe(front_object, verbose: true, **options, &specs)
    t = ::Fix::Test.new(front_object, verbose: verbose, **options, &specs)

    print t.report.to_s if verbose
    exit t.pass?
  end
end

require_relative File.join 'fix', 'it'
require_relative File.join 'fix', 'on'
