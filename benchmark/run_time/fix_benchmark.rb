# frozen_string_literal: true

require "benchmark"

fname   = File.join(File.dirname(__FILE__), "fix_code.rb")
command = "ruby #{fname}"

time = Benchmark.measure do
  `#{command}`
end

puts time # => 0.023792   0.030860   3.928566 (  3.887459)
