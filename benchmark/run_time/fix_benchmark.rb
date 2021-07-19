# frozen_string_literal: true

require "benchmark"

fname   = File.join(File.dirname(__FILE__), "fix_code.rb")
command = "ruby #{fname}"

time = Benchmark.measure do
  `#{command}`
end

puts time # => 0.179065   0.232710  38.598965 ( 38.331386)
