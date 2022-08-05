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

puts time

# ruby benchmark/boot_time/minitest_benchmark.rb
#   0.020462   0.025070   9.149878 (  9.178615)
