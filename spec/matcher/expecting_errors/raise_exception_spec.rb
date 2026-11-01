# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#raise_exception" do
  it { expect { RSpec::Clone::Boom! }.to raise_exception(NameError) }
  it { expect { :foo }.not_to raise_exception(NameError) }
  it { expect { raise "boom" }.to raise_exception(RuntimeError, "boom") }
  it { expect { raise "boom" }.to raise_exception(RuntimeError, /oo/) }
  it { expect { raise "boom" }.not_to raise_exception(RuntimeError, "bang") }
end

# spec/matcher/expecting_errors/raise_exception_spec.rb:6: Success: expected #<NoMethodError: undefined method 'Boom!' for module RSpec::Clone> to raise exception NameError
# spec/matcher/expecting_errors/raise_exception_spec.rb:7: Success: expected :foo not to raise exception NameError
# spec/matcher/expecting_errors/raise_exception_spec.rb:8: Success: expected #<RuntimeError: boom> to raise exception RuntimeError with message "boom"
# spec/matcher/expecting_errors/raise_exception_spec.rb:9: Success: expected #<RuntimeError: boom> to raise exception RuntimeError with message /oo/
# spec/matcher/expecting_errors/raise_exception_spec.rb:10: Success: expected #<RuntimeError: boom> not to raise exception RuntimeError with message "bang"
