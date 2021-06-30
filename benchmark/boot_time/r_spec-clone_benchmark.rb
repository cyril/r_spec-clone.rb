# frozen_string_literal: true

require "benchmark"

fname   = File.join(File.dirname(__FILE__), "r_spec-clone_code.rb")
command = "ruby #{fname}"

time = Benchmark.measure do
  100.times do
    `#{command}`

    # @example
    #   Success: expected false not to be true.
  end
end

puts time # => 0.015756   0.078918  15.328725 ( 15.644231)
