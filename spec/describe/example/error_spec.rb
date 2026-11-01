# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe RSpec do
  context "when the block of an expectation raises" do
    subject do
      ::RSpec.describe Integer do
        it { expect { raise "boom" }.to be_nil }
      end
    rescue ::SystemExit => e
      e.success?
    end

    it { is_expected.to be_false }
  end
end

# spec/describe/example/error_spec.rb:9: Error: RuntimeError: boom
#   spec/describe/example/error_spec.rb:9:in 'block (6 levels) in <main>'
#   spec/describe/example/error_spec.rb:9:in 'block (5 levels) in <main>'
#   spec/describe/example/error_spec.rb:9:in 'block (4 levels) in <main>'
#   spec/describe/example/error_spec.rb:8:in 'block (3 levels) in <main>'
#   spec/describe/example/error_spec.rb:15:in 'block (3 levels) in <main>'
#   spec/describe/example/error_spec.rb:15:in 'block (2 levels) in <main>'
#   spec/describe/example/error_spec.rb:6:in 'block in <main>'
#   spec/describe/example/error_spec.rb:5:in '<main>'
# spec/describe/example/error_spec.rb:15: Success: expected false to be false
