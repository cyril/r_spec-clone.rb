# frozen_string_literal: true

require "benchmark"

time = Benchmark.measure do
  100.times do
    `rspec rspec/code.rb`

    # @example
    #   .
    #
    #   Finished in 0.00716 seconds (files took 0.23434 seconds to load)
    #   1 example, 0 failures
    #
  end
end

puts time # => 0.018732   0.104511  32.212720 ( 32.765222)
