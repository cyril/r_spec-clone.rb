# frozen_string_literal: true

require "benchmark"

fname   = File.join(File.dirname(__FILE__), "minitest_code.rb")
command = "ruby #{fname}"

time = Benchmark.measure do
  `#{command}`
end

puts time # => 0.180960   0.402894   4.405005 (  3.842721)
