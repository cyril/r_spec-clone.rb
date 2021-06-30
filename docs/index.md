# RSpec clone

A minimalist __RSpec clone__ with all the essentials.

![What did you RSpec?](https://github.com/cyril/r_spec-clone.rb/raw/main/img/what-did-you-rspec.jpg)

## Status

[![Version](https://img.shields.io/github/v/tag/cyril/r_spec-clone.rb?label=Version&logo=github)](https://github.com/cyril/r_spec-clone.rb/releases)
[![Yard documentation](https://img.shields.io/badge/Yard-documentation-blue.svg?logo=github)](https://rubydoc.info/github/cyril/r_spec-clone.rb/main)
[![CI](https://github.com/cyril/r_spec-clone.rb/workflows/CI/badge.svg?branch=main)](https://github.com/cyril/r_spec-clone.rb/actions?query=workflow%3Aci+branch%3Amain)
[![RuboCop](https://github.com/cyril/r_spec-clone.rb/workflows/RuboCop/badge.svg?branch=main)](https://github.com/cyril/r_spec-clone.rb/actions?query=workflow%3Arubocop+branch%3Amain)
[![License](https://img.shields.io/github/license/cyril/r_spec-clone.rb?label=License&logo=github)](https://github.com/cyril/r_spec-clone.rb/raw/main/LICENSE.md)

## Project goals

1. Keep a low level of code complexity and ensure thread safety.
2. The interface must translate into atomic and simple Ruby objects.
3. Avoid overloading the interface with additional alternative syntaxes.
4. Provide most of RSpec's DSL to express expected outcomes of a code example.

## Some differences

* Spec files can be executed with `ruby` directly.
* There is no option to activate monkey-patching.
* It does not rely on hacks such as [`at_exit` hook](https://blog.arkency.com/2013/06/are-we-abusing-at-exit/) to trigger the tests.
* Built-in matchers [do not trust _actual_](https://asciinema.org/a/29172?autoplay=1&speed=2) and do not send it messages.
* If no `subject` has been explicitly determined, none is defined.
* If no described class is set, `described_class` is undefined instead of `nil`.
* Expectations cannot be added inside a `before` block.
* [Arbitrary helper methods](https://relishapp.com/rspec/rspec-core/v/3-10/docs/helper-methods/arbitrary-helper-methods) are not exposed to examples.
* The `let` method defines a helper method rather than a memoized helper method.
* The one-liner `is_expected` syntax also works with block expectations.
* `subject`, `before`, `after` and `let` definitions must come before examples.
* Groups and examples are _executed in subprocesses_ the order they are defined.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "r_spec-clone"
```

And then execute:

```sh
bundle
```

Or install it yourself as:

```sh
gem install r_spec-clone
```

## Overview

__RSpec clone__ provides a structure for writing executable examples of how your code should behave.

Inspired by RSpec, it includes a domain specific language (DSL) that allows you to write examples in a way similar to plain english.

A basic spec looks something like this:

[![RSpec clone demo](https://asciinema.org/a/422210.svg)](https://asciinema.org/a/422210?autoplay=1&speed=2)

## Usage

### Anatomy of a spec file

To use the `RSpec` module and its DSL, you need to add `require "r_spec/clone"` to your spec files.
Many projects use a custom spec helper which organizes these includes.

Concrete test cases are defined in `it` blocks.
An optional descriptive string states it's purpose and a block contains the main logic performing the test.

Test cases that have been defined or outlined but are not yet expected to work can be defined using `pending` instead of `it`. They will not be run but show up in the spec report as pending.

An `it` block contains an example that should invoke the code to be tested and define what is expected of it.
Each example can contain multiple expectations, but it should test only one specific behaviour.

To express an expectation, wrap an object or block in `expect`, call `to` (or `not_to`) and pass it a matcher object.
If the expectation is met, code execution continues.
Otherwise the example has _failed_ and other code will not be executed.

In test files, specs are structured by example groups which are defined by `describe` and `context` sections.
Typically a top level `describe` defines the outer unit (such as a class) to be tested by the spec.
Further `describe` sections can be nested within the outer unit to specify smaller units under test (such as individual methods).

For unit tests, it is recommended to follow the conventions for method names:

* outer `describe` is the name of the class, inner `describe` targets methods;
* instance methods are prefixed with `#`, class methods with `.`.

To establish certain contexts — think _empty array_ versus _array with elements_ — the `context` method may be used to communicate this to the reader.

### Expectations

Expectations define if the value being tested (_actual_) matches a certain value or specific criteria.

#### Equivalence

```ruby
expect(actual).to eql(expected) # passes if expected.eql?(actual)
expect(actual).to eq(expected)  # passes if expected.eql?(actual)
```

#### Identity

```ruby
expect(actual).to equal(expected) # passes if expected.equal?(actual)
expect(actual).to be(expected)    # passes if expected.equal?(actual)
```

#### Regular expressions

```ruby
expect(actual).to match(expected) # passes if expected.match?(actual)
```

#### Expecting errors

```ruby
expect { actual }.to raise_exception(expected) # passes if expected exception is raised
```

#### Truth

```ruby
expect(actual).to be_true # passes if true.equal?(actual)
```

#### Untruth

```ruby
expect(actual).to be_false # passes if false.equal?(actual)
```

#### Nil

```ruby
expect(actual).to be_nil # passes if nil.equal?(actual)
```

#### Type/class

```ruby
expect(actual).to be_instance_of(expected)    # passes if expected.equal?(actual.class)
expect(actual).to be_an_instance_of(expected) # passes if expected.equal?(actual.class)
```

### Running specs

By convention, specs live in the `spec/` directory of a project. Spec files should end with `_spec.rb` to be recognizable as such.

Depending of the project settings, you may run the specs of a project by running `rake spec` (see _Rake integration example_ section below).
A single file can also be executed directly with the Ruby interpreter.

#### Examples

Run all specs in files matching `spec/**/*_spec.rb`:

```sh
bundle exec rake spec
```

Run a single file:

```sh
ruby spec/my/test/file_spec.rb
```

It is not recommended, but the RSpec's [`rspec` command line](https://relishapp.com/rspec/rspec-core/docs/command-line) might also work:

```sh
rspec spec/my/test/file_spec.rb
rspec spec/my/test/file_spec.rb:42
rspec spec/my/test/
rspec
```

### Spec helper

Many projects use a custom spec helper file, usually named `spec/spec_helper.rb`.

This file is used to require `r_spec/clone` and other includes, like the code from the project needed for every spec file.

### Rake integration example

The following `Rakefile` settings should be enough:

```ruby
require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.pattern = "spec/**/*_spec.rb"
end

task spec: :test
task default: :test
```

And then execute:

```sh
bundle exec rake
```

## Performance

### Runtime

Benchmark against [100 executions of a file containing one expectation](https://github.com/cyril/r_spec-clone.rb/blob/main/benchmark/) (lower is better).

![Runtime](https://r-spec.dev/benchmark-runtime.png)

## Test suite

__RSpec clone__'s specifications are self-described here: [spec/](https://github.com/cyril/r_spec-clone.rb/blob/main/spec/)

## Contact

* Home page: [https://r-spec.dev/](https://r-spec.dev/)
* Cheatsheet: [https://r-spec.dev/cheatsheet.html](https://r-spec.dev/cheatsheet.html)
* Source code: [https://github.com/cyril/r_spec-clone.rb](https://github.com/cyril/r_spec-clone.rb)
* API Doc: [https://rubydoc.info/gems/r_spec-clone](https://rubydoc.info/gems/r_spec-clone)
* Twitter: [https://twitter.com/cyri\_](https://twitter.com/cyri\_)

## Special thanks ❤️

I would like to thank the whole [RSpec team](https://rspec.info/about/) for all their work.
It's a great framework and it's a pleasure to work with every day.

Without RSpec, this clone would not have been possible.

## Buy me a coffee ☕

If you like this project, please consider making a small donation to Batman.

[![Donate](https://img.shields.io/badge/Donate-batman.eth-purple.svg)](https://etherscan.io/address/batman.eth)

## Versioning

__RSpec clone__ follows [Semantic Versioning 2.0](https://semver.org/).

## License

The [gem](https://rubygems.org/gems/r_spec-clone) is available as open source under the terms of the [MIT License](https://github.com/cyril/r_spec-clone.rb/raw/main/LICENSE.md).

## One more thing

Under the hood, __RSpec clone__ is largely animated by [a collection of testing libraries designed to make programmers happy](https://github.com/fixrb/).

It's a living example of what we can do combining small libraries together that can boost the fun of programming.

![Fix testing tools logo for Ruby](https://github.com/cyril/r_spec-clone.rb/raw/main/img/fixrb.svg)
