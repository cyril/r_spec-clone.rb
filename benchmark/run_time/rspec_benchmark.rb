# frozen_string_literal: true

require "benchmark"

fname   = File.join(File.dirname(__FILE__), "rspec_code.rb")
command = "ruby #{fname}"

time = Benchmark.measure do
  `#{command}`
end

puts time # => 2.023344   4.558970 327.926166 (325.831040)
