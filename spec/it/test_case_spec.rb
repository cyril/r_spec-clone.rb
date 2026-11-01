# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.it { expect(42).to be_within(2).of(40) }

# spec/it/test_case_spec.rb:5: Success: expected 42 to be within 2 of 40
