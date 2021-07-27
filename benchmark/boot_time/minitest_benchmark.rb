# frozen_string_literal: true

require "benchmark"

fname   = File.join(File.dirname(__FILE__), "minitest_code.rb")
command = "ruby #{fname}"

time = Benchmark.measure do
  100.times do
    `#{command}`

    # @example
    #   Run options: --seed 5408
    #
    #   # Running:
    #
    #   .
    #
    #   Finished in 0.000931s, 1074.1139 runs/s, 1074.1139 assertions/s.
    #
    #   1 runs, 1 assertions, 0 failures, 0 errors, 0 skips
  end
end

puts time # => 0.016186   0.078629  19.266454 ( 19.645545)
