# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.it { expect(42).to be_within(2).of(40) }
