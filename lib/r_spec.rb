# Namespace for the RSpec framework.
#
# @api public
#
module RSpec
  # Specs are built with this method.
  #
  # @example 42 must be equal to 42
  #   describe(42) do
  #     it { MUST Equal: 42 }
  #   end
  #
  # @param front_object [#object_id]  The front object.
  # @param options      [Hash]        Some options.
  # @param specs        [Proc]        The set of specs.
  #
  # @raise [SystemExit] The result of the test.
  def self.describe(front_object, options = {}, &specs)
    t = ::Fix::Test.new(front_object, options, &specs)

    print "#{t.report}" if options.fetch(:verbose, true)
    exit t.pass?
  end
end

require 'fix/expect'
require 'fix/its'
require 'matchi/rspec'

require_relative File.join 'fix', 'before'
require_relative File.join 'fix', 'it'
require_relative File.join 'fix', 'describe'
