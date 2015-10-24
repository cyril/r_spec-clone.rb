require_relative File.join 'support', 'coverage'
require_relative File.join '..', 'lib', 'r_spec'
require 'spectus'

begin
  RSpec.describe 'test' do
    describe 'test' do
      it 'does something' do
        expect(nil).to be_nil
      end
    end
  end
rescue SystemExit => e
  Spectus.this { e.success? }.MUST :BeTrue
end
