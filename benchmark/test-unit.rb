# frozen_string_literal: true

require "benchmark"

time = Benchmark.measure do
  100.times do
    `ruby test-unit/code.rb`

    # @example
    #   Loaded suite test-unit/code
    #   Started
    #   .
    #   Finished in 0.000697 seconds.
    #   ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    #   1 tests, 1 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications
    #   100% passed
    #   ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    #   1434.72 tests/s, 1434.72 assertions/s
  end
end

puts time # => 0.019840   0.097015  20.572792 ( 20.921131)
