# frozen_string_literal: true

require_relative File.join("..", "..", "spec_helper")

RSpec.describe "#raise_exception" do
  it { expect { RSpec::Clone::Boom! }.to raise_exception(NameError) }
  it { expect { :foo }.not_to raise_exception(NameError) }
end

# Success: undefined method `Boom!' for RSpec::Clone:Module.
# Success: expected :foo not to raise exception NameError.
