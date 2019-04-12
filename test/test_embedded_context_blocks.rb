# frozen_string_literal: true

unless Process.respond_to?(:fork)
  warn 'Info: fork is not implemented on the current platform.'
  exit
end

require_relative File.join 'support', 'coverage'
require_relative File.join '..', 'lib', 'r_spec'
require 'spectus'

include Spectus

begin
  RSpec.describe 'test' do
    context 'test' do
      context 'test' do
        it 'does something' do
          expect(:foo).to eq(:foo)
        end
      end
    end
  end
rescue SystemExit => e
  it { e.success? }.MUST be_true
end
