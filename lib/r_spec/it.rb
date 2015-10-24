module RSpec
  # Module to extend Fix's It class.
  module It
    private

    # Override Ruby's method_missing in order to coerce matchers.
    #
    # @api private
    #
    # @raise [NoMethodError] If doesn't respond to the given method.
    def method_missing(name, *args)
      matcher = name.to_s.split('_').map(&:capitalize).join.to_sym

      return unless Matchi.constants.include?(matcher)

      if args.any?
        { matcher => (args.length.equal?(1) ? args.first : args) }
      else
        matcher
      end
    end
  end
end
