# frozen_string_literal: true

require "benchmark"

fname   = File.join(File.dirname(__FILE__), "r_spec-clone_code.rb")
command = "ruby #{fname}"

time = Benchmark.measure do
  100.times do
    `#{command}`

    # @example
    #   Success: expected to be true.
  end
end

puts time # => 0.017863   0.083490  13.928390 ( 14.235524)
