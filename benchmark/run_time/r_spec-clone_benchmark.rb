# frozen_string_literal: true

require "benchmark"

fname   = File.join(File.dirname(__FILE__), "r_spec-clone_code.rb")
command = "ruby #{fname}"

time = Benchmark.measure do
  `#{command}`
end

puts time

# ruby benchmark/run_time/r_spec-clone_benchmark.rb
#   0.045563   0.038508   1.799406 (  1.715572)
