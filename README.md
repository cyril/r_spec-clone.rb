# <abbr title="Ruby">R</abbr>Spec

[![Build Status](https://travis-ci.org/cyril/r_spec.svg?branch=master)][travis]
[![Code Climate](https://codeclimate.com/github/cyril/r_spec/badges/gpa.svg)][codeclimate]
[![Gem Version](https://badge.fury.io/rb/r_spec.svg)][gem]
[![Inline docs](https://inch-ci.org/github/cyril/r_spec.svg?branch=master)][inchpages]
[![Documentation](https://img.shields.io/:yard-docs-38c800.svg)][rubydoc]

> A small [RSpec](https://github.com/rspec/rspec) clone based on [Fix specing framework](https://github.com/fixrb/fix).

***

## Important ⚠️

To avoid confusion in the community, please note that the gem of this project is **not [rspec](https://rubygems.org/gems/rspec)**, it is **[r_spec](https://rubygems.org/gems/r_spec)** (meaning _Ruby Spec_).

This project is totally independent of [rspec.info](https://rspec.info/).

Also, while both gems define an `RSpec` module, **r_spec** (which follows [the gem naming convention](https://guides.rubygems.org/name-your-gem/#use-underscores-for-multiple-words)) is still quite different than **rspec** due to its [Fix](https://fixrb.dev/) dependency.

## Terminal sessions

A comparison between the behavior of a small fix-based script (which became the `r_spec` gem) and `rspec`.

As a result, with `r_spec` the build is passing, while with rspec it is failing. Despite two separate contexts, `rspec` was not able to evaluate some code in isolation to prevent side effects.

[![What did you RSpec?](https://asciinema.org/a/29070.png)](https://asciinema.org/a/29070)

***

Unbelievable but true, sometimes "💩" is equal to 42.

Although fun, this _feature_ can be fixed pretty easily...

[![Fix RSpec!](https://asciinema.org/a/29172.png)](https://asciinema.org/a/29172)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'r_spec'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install r_spec

## Usage

Given this `greeting_spec.rb` spec:

```ruby
require 'r_spec'

greeting = 'Hello, world!'

RSpec.describe 'Test' do
  context 'Alice' do
    before { greeting.gsub!('world', 'Alice') }
    it { expect(greeting).to eql 'Hello, Alice!' }
  end

  context 'Bob' do
    before { greeting.gsub!('world', 'Bob') }
    it { expect(greeting).to eql 'Hello, Bob!' }
  end
end
```

It can be tested in the console with the command:

    $ ruby greeting_spec.rb
    ..

    Ran 2 tests in 0.010994 seconds
    100% compliant - 0 infos, 0 failures, 0 errors

## Contact

* Source code: https://github.com/cyril/r_spec

## Versioning

__R Spec__ follows [Semantic Versioning 2.0](https://semver.org/).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

[gem]: https://rubygems.org/gems/r_spec
[travis]: https://travis-ci.org/cyril/r_spec
[codeclimate]: https://codeclimate.com/github/cyril/r_spec
[inchpages]: https://inch-ci.org/github/cyril/r_spec
[rubydoc]: https://www.rubydoc.info/gems/r_spec/frames
