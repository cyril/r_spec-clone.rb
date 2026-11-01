# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.describe RSpec::Clone::Dsl do
  describe ".pending" do
    pending "is implemented but waiting" do
      # expect something to be finished
    end

    pending "is not yet implemented and waiting"
  end
end

# spec/describe/dsl_pending_spec.rb:7: Pending: is implemented but waiting
# spec/describe/dsl_pending_spec.rb:11: Pending: is not yet implemented and waiting
