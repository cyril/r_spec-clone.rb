# frozen_string_literal: true

require "benchmark"

fname   = File.join(File.dirname(__FILE__), "test-unit_code.rb")
command = "ruby #{fname}"

time = Benchmark.measure do
  100.times do
    `#{command}`

    # @example
    #   Loaded suite benchmark/boot_time/test-unit_code
    #   Started
    #   .
    #   Finished in 0.000676 seconds.
    #   ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
    #   1 tests, 1 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications
    #   100% passed
    #   ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
    #   1479.29 tests/s, 1479.29 assertions/s
  end
end

puts time # => 0.020836   0.106863  22.035421 ( 22.550406)
