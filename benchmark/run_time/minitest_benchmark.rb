# frozen_string_literal: true

require "benchmark"

fname   = File.join(File.dirname(__FILE__), "minitest_code.rb")
command = "ruby #{fname}"

time = Benchmark.measure do
  `#{command}`
end

puts time # => 1.773555   3.608184  44.159389 ( 38.840379)
