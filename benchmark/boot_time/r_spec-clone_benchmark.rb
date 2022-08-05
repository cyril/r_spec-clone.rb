# frozen_string_literal: true

require "benchmark"

fname   = File.join(File.dirname(__FILE__), "r_spec-clone_code.rb")
command = "ruby #{fname}"

time = Benchmark.measure do
  100.times do
    `#{command}`

    # @example
    #   Success: expected to be true.
  end
end

puts time

# ruby benchmark/boot_time/r_spec-clone_benchmark.rb
#   0.037904   0.000000   6.930147 (  6.912589)
