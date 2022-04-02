# frozen_string_literal: true

require "benchmark"

fname   = File.join(File.dirname(__FILE__), "rspec_code.rb")
command = "ruby #{fname}"

time = Benchmark.measure do
  100.times do
    `#{command}`

    # @example
    #   .
    #
    #   Finished in 0.01081 seconds (files took 0.22844 seconds to load)
    #   1 example, 0 failures
    #
  end
end

puts time # => 0.031057   0.018383  11.727866 ( 11.700246)
