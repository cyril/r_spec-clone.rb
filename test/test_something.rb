require_relative File.join 'support', 'coverage'
require_relative File.join '..', 'lib', 'r_spec'
require 'spectus'

begin
  RSpec.describe 'test' do
    it 'does something' do
      expect(:foo).to eq(:foo)
    end
  end
rescue SystemExit => e
  Spectus.this { e.success? }.MUST :BeTrue
end
