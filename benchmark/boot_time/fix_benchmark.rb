# frozen_string_literal: true

require "benchmark"

fname   = File.join(File.dirname(__FILE__), "fix_code.rb")
command = "ruby #{fname}"

time = Benchmark.measure do
  100.times do
    `#{command}`

    # @example
    #   Success: expected false not to equal true.
  end
end

puts time # => 0.017533   0.090548  13.758190 ( 14.102381)
