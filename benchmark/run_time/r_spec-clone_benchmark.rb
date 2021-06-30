# frozen_string_literal: true

require "benchmark"

fname   = File.join(File.dirname(__FILE__), "r_spec-clone_code.rb")
command = "ruby #{fname}"

time = Benchmark.measure do
  `#{command}`
end

puts time # => 0.082755   0.193123  79.405230 ( 80.327756)
