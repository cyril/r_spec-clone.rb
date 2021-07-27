# frozen_string_literal: true

require "benchmark"

fname   = File.join(File.dirname(__FILE__), "rspec_code.rb")
command = "ruby #{fname}"

time = Benchmark.measure do
  `#{command}`
end

puts time # => 0.188054   0.429269  26.913786 ( 26.353259)
