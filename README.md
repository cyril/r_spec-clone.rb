# R Spec

[![Build Status](https://travis-ci.org/cyril/r_spec.svg?branch=master)][travis]
[![Code Climate](https://codeclimate.com/github/cyril/r_spec/badges/gpa.svg)][codeclimate]
[![Gem Version](https://badge.fury.io/rb/r_spec.svg)][gem]
[![Inline docs](http://inch-ci.org/github/cyril/r_spec.svg?branch=master)][inchpages]
[![Documentation](http://img.shields.io/:yard-docs-38c800.svg)][rubydoc]

> A small [Rspec](https://github.com/rspec/rspec) clone based on [Fix specing framework](https://github.com/fixrb/fix).

***

:warning: Important:

To avoid confusion in the community, please note that the gem of this project is **not [rspec](https://rubygems.org/gems/rspec)**, it is **[r_spec](https://rubygems.org/gems/r_spec)** (meaning _Ruby Spec_).

This project is totally independent of [rspec.info](http://rspec.info/).

Also, while both gems define an `RSpec` module, **r_spec** (which follows [the gem naming convention](http://guides.rubygems.org/name-your-gem/#use-underscores-for-multiple-words)) is still quite different than **rspec** due to its [Ruby Fix](http://fixrb.org/) dependency.

***

## Contact

* Home page: https://github.com/cyril/r_spec
* Bugs/issues: https://github.com/cyril/r_spec/issues

## Rubies

* [MRI](https://www.ruby-lang.org/)
* [Rubinius](http://rubini.us/)
* [JRuby](http://jruby.org/)

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

## Security

As a basic form of security __R Spec__ provides a set of SHA512 checksums for
every Gem release.  These checksums can be found in the `checksum/` directory.
Although these checksums do not prevent malicious users from tampering with a
built Gem they can be used for basic integrity verification purposes.

The checksum of a file can be checked using the `sha512sum` command.  For
example:

    $ sha512sum pkg/r_spec-0.1.0.gem
    e9e35e1953104e2d428b0f217e418db3c1baecd9e011b2545f9fcba4ff7e3bba674c6b928b3d8db842a139cd7cc9806d77ebdc7f710ece4f2aecb343703e2451  pkg/r_spec-0.1.0.gem

## Versioning

__R Spec__ follows [Semantic Versioning 2.0](http://semver.org/).

## Contributing

1. [Fork it](https://github.com/cyril/r_spec/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

See `LICENSE.md` file.

[gem]: https://rubygems.org/gems/r_spec
[travis]: https://travis-ci.org/cyril/r_spec
[codeclimate]: https://codeclimate.com/github/cyril/r_spec
[inchpages]: http://inch-ci.org/github/cyril/r_spec
[rubydoc]: http://rubydoc.info/gems/r_spec/frames
