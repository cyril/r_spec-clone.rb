# frozen_string_literal: true

require "benchmark"

fname   = File.join(File.dirname(__FILE__), "fix_code.rb")
command = "ruby #{fname}"

time = Benchmark.measure do
  100.times do
    `#{command}`

    # @example
    #   benchmark/boot_time/fix_code.rb:6 Success: expected to be true.
  end
end

puts time # => 0.017118   0.083964  13.793807 ( 14.153668)
