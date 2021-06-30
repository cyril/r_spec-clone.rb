# frozen_string_literal: true

require "benchmark"

fname   = File.join(File.dirname(__FILE__), "rspec_code.rb")
command = "ruby #{fname}"

time = Benchmark.measure do
  `#{command}`
end

puts time # => 0.022889   0.051639   3.131523 (  3.079825)
