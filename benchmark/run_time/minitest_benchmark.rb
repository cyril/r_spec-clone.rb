# frozen_string_literal: true

require "benchmark"

fname   = File.join(File.dirname(__FILE__), "minitest_code.rb")
command = "ruby #{fname}"

time = Benchmark.measure do
  `#{command}`
end

puts time

# ruby benchmark/run_time/minitest_benchmark.rb
#   0.000409   0.000045   0.313974 (  0.316281)
