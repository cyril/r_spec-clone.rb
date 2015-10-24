require_relative File.join '..', 'r_spec', 'it'

# Namespace for the Fix framework.
module Fix
  # Override Fix's It class.
  class It
    include ::RSpec::It
  end
end
