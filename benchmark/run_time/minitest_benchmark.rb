# frozen_string_literal: true

require "benchmark"

fname   = File.join(File.dirname(__FILE__), "minitest_code.rb")
command = "ruby #{fname}"

time = Benchmark.measure do
  `#{command}`
end

puts time # => 0.020127   0.042184   0.632380 (  0.577380)
