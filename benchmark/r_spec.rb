# frozen_string_literal: true

require "benchmark"

time = Benchmark.measure do
  100.times do
    `ruby r_spec/code.rb`

    # @example
    #   Success: expected false not to be true.
  end
end

puts time # => 0.016296   0.083269  12.887880 ( 13.208182)
