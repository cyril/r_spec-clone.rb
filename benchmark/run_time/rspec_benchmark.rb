# frozen_string_literal: true

require "benchmark"

fname   = File.join(File.dirname(__FILE__), "rspec_code.rb")
command = "ruby #{fname}"

time = Benchmark.measure do
  `#{command}`
end

puts time

# ruby benchmark/run_time/rspec_benchmark.rb
#   1.218680   1.196906  19.483955 ( 17.068815)
