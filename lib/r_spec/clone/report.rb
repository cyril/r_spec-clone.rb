# frozen_string_literal: true

require "defi"
require "matchi"
require "spectus"

module RSpec
  module Clone
    # Writes what happened, one line each: `file:line: Outcome: summary`,
    # as Spectus says it. A met expectation goes to the standard output; one
    # that is not met goes to the standard error and ends the process with
    # the status 1, since the rest of the file would run on a false premise.
    module Report
      # The lib directories of the clone and of the gems it runs, each found
      # by a method of its own, not by the name of a file, which another
      # file could bear, nor by the first file that opened its module, which
      # a spec could be: their frames are left out of the backtrace of an
      # error.
      LIBRARIES = ([
        ::Defi::Challenge.instance_method(:to).source_location,
        ::Matchi::Be.instance_method(:match?).source_location,
        ::Spectus::Requirement.instance_method(:call).source_location
      ].map { |location| "#{::File.expand_path("../..", location.fetch(0))}/" } << "#{::File.expand_path("../..", __dir__)}/").freeze

      private_constant :LIBRARIES

      # Writes the result of an expectation.
      #
      # @param location [String] `file:line`, where the expectation is written
      # @param result [Spectus::Result] how it went
      # @return [nil]
      # @raise [SystemExit] when the expectation is not met, after writing it
      def self.result(location, result)
        lines = ["#{location}: #{result}".gsub(/\R/) { "\\n" }]
        frames = result.backtrace || []
        frames.each { |frame| lines << "  #{frame.gsub(/\R/) { "\\n" }}" unless frame.start_with?(*LIBRARIES) }
        return $stdout.puts(lines) if result.passed?

        $stdout.flush
        abort(lines.join("\n"))
      end

      # Writes a pending example.
      #
      # @param location [String] `file:line`, where the example is written
      # @param message [String] why it is pending, written as valid UTF-8
      # @return [nil]
      def self.pending(location, message)
        message = message.to_s.encode(::Encoding::UTF_8, invalid: :replace, undef: :replace)
        $stdout.puts("#{location}: Pending: #{message}".gsub(/\R/) { "\\n" })
      end

      # Where the spec is: the first frame of the caller that is not in the
      # clone's own files, as `file:line`, the file relative to the current
      # directory when it is under it, as valid UTF-8.
      #
      # @return [String]
      def self.location
        frame = caller_locations.find { |location| !location.path.start_with?(LIBRARIES.last) }
        path = ::File.absolute_path(frame.path).delete_prefix(::File.join(::Dir.pwd, ""))
        "#{path}:#{frame.lineno}".encode(::Encoding::UTF_8, invalid: :replace, undef: :replace)
      end
    end
  end
end
