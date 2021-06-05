# RSpec clone

A minimalist [RSpec](https://github.com/rspec/rspec) clone with all the essentials.

![What did you expect?](https://github.com/cyril/r_spec.rb/raw/main/img/what-did-you-expect.jpg)

## Status

[![Gem Version](https://badge.fury.io/rb/r_spec.svg)](https://badge.fury.io/rb/r_spec)
[![Build Status](https://travis-ci.org/cyril/r_spec.rb.svg?branch=main)](https://travis-ci.org/cyril/r_spec.rb)
[![Inline Docs](https://inch-ci.org/github/cyril/r_spec.rb.svg)](https://inch-ci.org/github/cyril/r_spec.rb)

## Goal

This clone attempts to provide most of RSpec's DSL without magic power.

## Some differences

* Less features and an implementation with much less code complexity.
* Spec files can also be executed directly with the `ruby` executable.
* There is no option to activate monkey-patching.
* Does not rely on hacks such as `at_exit` hook to trigger the tests.
* Built-in matchers do not trust _actual_ and do not send it any message.
* The subject must be explicitly defined, otherwise it is not implemented.

## Important ⚠️

To avoid confusion in the community, please note that:

- the gem of this project is **not [`rspec`](https://rubygems.org/gems/rspec)**,
it is **[`r_spec`](https://rubygems.org/gems/r_spec)**;
- this project is totally independent of [rspec.info](https://rspec.info/).

### Note

Following [RubyGems naming conventions](https://guides.rubygems.org/name-your-gem/#use-underscores-for-multiple-words), the module name for this project is `RSpec`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "r_spec", ">= 1.0.0.beta2"
```

And then execute:

```sh
bundle
```

Or install it yourself as:

```sh
gem install r_spec --pre
```

## Usage

To understand how the framework builds and runs tests, here are some correspondences between the DSL syntax and the generated Ruby code.

### `describe` method

Example of specification content:

```ruby
RSpec.describe String do
end
```

Corresponding Ruby code:

```ruby
module RSpec::Test
  class Test3582143298
    protected

    def described_class
      String
    end
  end
end
```

### `context` method

The behavior of the `context` method is exactly the same as `describe`.

### `subject` method

Example of specification content:

```ruby
RSpec.describe "Subject" do
  subject do
    :foo
  end
end
```

Corresponding Ruby code:

```ruby
module RSpec::Test
  class Test3582143298
    protected

    def subject
      :foo
    end
  end
end
```

### Embedded `describe` method

Example of specification content:

```ruby
RSpec.describe "Describe" do
  # main describe block

  describe "Embedded describe" do
    # embedded describe block
  end
end
```

Corresponding Ruby code:

```ruby
module RSpec::Test
  class Test3582143298
    # main describe block
  end
end

module RSpec::Test
  class Test198623541 < RSpec::Test::Test3582143298
    # embedded describe block
  end
end
```

### `let` method

Example of specification content:

```ruby
RSpec.describe do
  let(:var0) { 42 }
  let(:var1) { 42 + var3 }
  let(:var3) { 42 }
end
```

Corresponding Ruby code:

```ruby
module RSpec::Test
  class Test3582143298
    protected

    def var0
      42
    end

    def var1
      42 + var3
    end

    def var3
      42
    end
  end
end
```

### `before` method

Example of specification content:

```ruby
RSpec.describe do
  before do
    puts "hello"
  end
end
```

Corresponding Ruby code:

```ruby
module RSpec::Test
  class Test3582143298
    def initialize
      puts "hello"
    end
  end
end
```

### `expect` method

Example of specification content:

```ruby
RSpec.describe do
  it { expect(41.next).to be(42) }
end
```

Corresponding Ruby code:

```ruby
module RSpec::Test
  class Test3582143298
  end
end

example_class = Class.new(RSpec::Test::Test3582143298) do
  include Matchi::Helper

  # Declaration of private methods (`expect`, `is_expected`, `log`, `pending`).
end

example_class.new.instance_eval do
  ExpectationTarget::Value.new(41.next).to be(42)
end
```

    Success: expected to be 42.

## Example

Let's test an array:

```ruby
# array_spec.rb

require "r_spec"

RSpec.describe Array do
  before do
    @elements = described_class.new
  end

  describe "#count" do
    subject do
      @elements.count
    end

    it { is_expected.to be 0 }

    context "when a new element is added" do
      before do
        @elements << 1
      end

      it { is_expected.to be 1 }
    end
  end
end
```

It can be tested in the console with the command:

```sh
ruby array_spec.rb
```

    array_spec.rb:15 Success: expected to be 0.
    array_spec.rb:22 Success: expected to be 1.

## Test suite

__RSpec clone__'s specifications are self-described here: [spec/](https://github.com/cyril/r_spec.rb/blob/main/spec/)

## Contact

* Home page: https://r-spec.dev
* Source code: https://github.com/cyril/r_spec.rb
* Twitter: [https://twitter.com/cyri\_](https://twitter.com/cyri\_)

## Versioning

__RSpec clone__ follows [Semantic Versioning 2.0](https://semver.org/).

## Special thanks

I would like to thank the whole [RSpec team](https://rspec.info/about/) for all their work.
It's a great framework and it's a pleasure to work with every day.

Without RSpec, this clone would not have been possible. ❤️

## License

The [gem](https://rubygems.org/gems/r_spec) is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
