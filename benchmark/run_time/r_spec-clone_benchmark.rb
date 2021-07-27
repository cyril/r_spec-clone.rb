# frozen_string_literal: true

require "benchmark"

fname   = File.join(File.dirname(__FILE__), "r_spec-clone_code.rb")
command = "ruby #{fname}"

time = Benchmark.measure do
  `#{command}`
end

puts time # => 0.015334   0.019418   2.626713 (  2.602114)
