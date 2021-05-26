# frozen_string_literal: true

require_relative File.join("test", "app")
require_relative File.join("test", "spec")

raise unless defined?(RSpec::Test::Foo::Fooo)
raise unless defined?(RSpec::Test::Foo)

foo = RSpec::Test::Foo.new(88)

puts "foo.protected_methods(false).sort: #{foo.protected_methods(false).sort.inspect}"
raise unless foo.protected_methods(false).sort == %i[var0 var1 var2 var4 described_class subject].sort
raise unless foo.send(:var0) == 84
raise unless foo.send(:var1) == 42
raise unless foo.send(:var2) == "A"
raise unless foo.class.const_get(:VAR3) == 4242
# raise unless foo.class::VAR3 == 4242
raise unless foo.send(:var4) == 4242

puts foo.works.inspect
# raise unless foo.works(5).success? == true

raise unless defined?(RSpec::Test::Bar)
raise unless RSpec::Test::Bar.superclass == RSpec::Test::Foo

bar = RSpec::Test::Bar.new

raise unless bar.send(:get_parent_const) == 4242
# raise unless bar.send(:subject) == "AB42"
raise unless bar.send(:other, 1) == 43

# raise unless foo.public_methods(false).empty?
# raise unless bar.public_methods(false).empty?

puts
puts
baz = RSpec::Test::Baz.new(:d)

raise unless baz.send(:get_parent_parent_const) == 4242
