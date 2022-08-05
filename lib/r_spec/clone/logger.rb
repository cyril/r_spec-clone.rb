# frozen_string_literal: true

module RSpec
  module Clone
    # Send log messages to the console.
    module Logger
      # @param report [::Expresenter::Pass] Passed expectation result presenter.
      #
      # @see https://github.com/fixrb/expresenter
      #
      # @return [nil] Add a colored message to `$stdout`.
      def self.passed_spec(report)
        puts report.colored_string
      end

      # :nocov:

      # @param report [::Expresenter::Fail] Failed expectation result presenter.
      #
      # @see https://github.com/fixrb/expresenter
      #
      # @raise [SystemExit] Terminate execution immediately with message.
      def self.failed_spec(report)
        abort report.colored_string
      end

      # :nocov:

      # The Ruby source filename and line number containing this method or nil
      # if this method was not defined in Ruby (i.e. native).
      #
      # @param filename [String, nil] The Ruby source filename.
      # @param line     [Integer, nil] The Ruby source line number.
      #
      # @return [String] The Ruby source filename and line number associated with
      #   the evaluated spec.
      def self.source(filename, line)
        puts [filename, line].compact.join(":")
      end
    end
  end
end
