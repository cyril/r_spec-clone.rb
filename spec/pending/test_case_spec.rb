# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.pending "is implemented but waiting" do
  expect something to be finished
end

RSpec.pending "is not yet implemented and waiting"

# spec/pending/test_case_spec.rb:5: Pending: is implemented but waiting
# spec/pending/test_case_spec.rb:9: Pending: is not yet implemented and waiting
