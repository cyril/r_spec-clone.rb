# frozen_string_literal: true

require "expresenter"

module RSpec
  module Clone
    module Error
      # Exception for pending expectations.
      class PendingExpectation < ::RuntimeError
        # @param message [String] The not implemented expectation description.
        #
        # @return [nil] Write a pending expectation to STDOUT.
        def self.result(message)
          ::Expresenter.call(true).with(
            actual:     new(message),
            definition: "raise exception #{self}",
            error:      nil,
            got:        false,
            negate:     true,
            level:      :SHOULD
          )
        end
      end
    end
  end
end
