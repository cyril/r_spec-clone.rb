# frozen_string_literal: true

require "benchmark"

fname   = File.join(File.dirname(__FILE__), "test-unit_code.rb")
command = "ruby #{fname}"

time = Benchmark.measure do
  `#{command}`
end

puts time # => 2.007092   4.292060 129.013514 (123.317196)
