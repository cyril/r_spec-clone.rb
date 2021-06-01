# RSpec clone

A minimalist [RSpec](https://github.com/rspec/rspec) clone with an emphasis on correctness and simplicity.

![What did you expect?](https://github.com/cyril/r_spec.rb/raw/main/img/what-did-you-expect.jpg)

## Status

[![Gem Version](https://badge.fury.io/rb/r_spec.svg)](https://badge.fury.io/rb/r_spec)
[![Build Status](https://travis-ci.org/cyril/r_spec.rb.svg?branch=main)](https://travis-ci.org/cyril/r_spec.rb)
[![Inline Docs](https://inch-ci.org/github/cyril/r_spec.rb.svg)](https://inch-ci.org/github/cyril/r_spec.rb)

## Goal

This clone attempts to provide most of RSpec's DSL without magic power, so that its code could reasonably become less complex than the code of your application.

## Some differences

* Less features and an implementation with much less code complexity.
* Spec files can also be executed directly with the `ruby` executable.
* There cannot be more than one expectation per example.
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
gem "r_spec", ">= 1.0.0.beta1"
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

Given this [./spec/before/before_example_spec.rb](https://github.com/cyril/r_spec.rb/blob/main/spec/before/before_example_spec.rb) spec:

```ruby
require "r_spec"

RSpec.describe Array do
  before do
    @elements = []
  end

  describe "initialized in before" do
    it "has 0 elements" do
      expect(@elements.count).to be(0)
    end

    context "when a new element is added" do
      before do
        @elements << 1
      end

      it "has 1 element" do
        expect(@elements.count).to be(1)
      end
    end
  end
end
```

It can be tested in the console with the command:

```sh
ruby spec/before/before_example_spec.rb
```

    spec/before/before_example_spec.rb:11 Success: expected to be 0.
    spec/before/before_example_spec.rb:20 Success: expected to be 1.
    Coverage report generated for RSpec clone to /Users/cyril/github/cyril/r_spec/coverage. 90 / 100 LOC (90.0%) covered.

## Test suite

__RSpec clone__'s test set is self-described here: [./spec/](https://github.com/cyril/r_spec.rb/blob/main/spec/)

## Contact

* Home page: [https://r-spec.dev/](https://r-spec.dev/)
* Source code: [https://github.com/cyril/r_spec.rb](https://github.com/cyril/r_spec.rb)
* Twitter: [https://twitter.com/cyri_](https://twitter.com/cyri_)

## Versioning

__RSpec clone__ follows [Semantic Versioning 2.0](https://semver.org/).

## License

The [gem](https://rubygems.org/gems/r_spec) is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
