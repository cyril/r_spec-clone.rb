# frozen_string_literal: true

require "benchmark"

fname   = File.join(File.dirname(__FILE__), "test-unit_code.rb")
command = "ruby #{fname}"

time = Benchmark.measure do
  `#{command}`
end

puts time # => 0.020897   0.045942   1.361790 (  1.304989)
