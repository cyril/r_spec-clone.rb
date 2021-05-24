# RSpec clone

A minimalist [RSpec](https://github.com/rspec/rspec) clone with an emphasis on correctness and simplicity.

## Status

[![Gem Version](https://badge.fury.io/rb/r_spec.svg)](https://badge.fury.io/rb/r_spec)
[![Build Status](https://travis-ci.org/cyril/r_spec.rb.svg?branch=main)](https://travis-ci.org/cyril/r_spec.rb)
[![Inline Docs](https://inch-ci.org/github/cyril/r_spec.rb.svg)](https://inch-ci.org/github/cyril/r_spec.rb)

## Important ⚠️

To avoid confusion in the community, please note that:

- the gem of this project is **not [`rspec`](https://rubygems.org/gems/rspec)**,
it is **[`r_spec`](https://rubygems.org/gems/r_spec)**;
- this project is totally independent of [rspec.info](https://rspec.info/).

## Note

Following [RubyGems naming conventions](https://guides.rubygems.org/name-your-gem/#use-underscores-for-multiple-words), the module name for this project is `RSpec`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "r_spec"
```

And then execute:

```sh
bundle
```

Or install it yourself as:

```sh
gem install r_spec
```

## Usage

Given this `greeting_spec.rb` spec:

```ruby
require "r_spec"

greeting = "Hello, world!"

RSpec.describe String do
  context "Alice" do
    before { greeting.gsub!("world", "Alice") }
    it { expect(greeting).to eql "Hello, Alice!" }
  end

  context "Bob" do
    before { greeting.gsub!("world", "Bob") }
    it { expect(greeting).to eql "Hello, Bob!" }
  end
end
```

It can be tested in the console with the command:

```sh
ruby greeting_spec.rb
```

> ..
>
> Ran 2 tests in 0.010994 seconds
> 100% compliant - 0 infos, 0 failures, 0 errors

## Contact

* Home page: https://r-spec.dev/
* Source code: https://github.com/cyril/r_spec.rb

## Versioning

__R_Spec__ follows [Semantic Versioning 2.0](https://semver.org/).

## License

The [gem](https://rubygems.org/gems/r_spec) is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
