# frozen_string_literal: true

require "benchmark"

time = Benchmark.measure do
  100.times do
    `ruby minitest/code.rb`

    # @example
    #   Run options: --seed 61144
    #
    #   # Running:
    #
    #   .
    #
    #   Finished in 0.001876s, 533.0491 runs/s, 533.0491 assertions/s.
    #
    #   1 runs, 1 assertions, 0 failures, 0 errors, 0 skips
  end
end

puts time # => 0.016416   0.084541  17.554826 ( 18.119474)
