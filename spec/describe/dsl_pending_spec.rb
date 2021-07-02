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

# Warning: is implemented but waiting.
# Warning: is not yet implemented and waiting.
