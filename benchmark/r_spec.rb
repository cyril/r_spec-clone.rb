# frozen_string_literal: true

require "benchmark"

time = Benchmark.measure do
  100.times do
    `ruby r_spec/code.rb`

    # @example
    #   Success: expected false not to be true.
  end
end

puts time # => 0.016865   0.077401  12.532842 ( 12.870667)
