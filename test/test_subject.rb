# frozen_string_literal: true

require_relative File.join 'support', 'coverage'
require_relative File.join '..', 'lib', 'r_spec'
require 'spectus'

include Spectus

begin
  RSpec.describe 'test the subject' do
    subject { 6 * 7 }

    it { is_expected.to eql 42 }
    it { expect(subject).to eql 42 }
  end
rescue SystemExit => e
  it { e.success? }.MUST be_true
end
