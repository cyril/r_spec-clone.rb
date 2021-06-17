# RSpec clone

A minimalist __[RSpec](https://github.com/rspec/rspec) clone__ with all the essentials.

![What did you RSpec?](https://github.com/cyril/r_spec.rb/raw/main/img/what-did-you-rspec.jpg)

## Status

[![Gem Version](https://badge.fury.io/rb/r_spec.svg)](https://badge.fury.io/rb/r_spec)
[![Build Status](https://travis-ci.org/cyril/r_spec.rb.svg?branch=main)](https://travis-ci.org/cyril/r_spec.rb)
[![Documentation](https://img.shields.io/:yard-docs-38c800.svg)](https://rubydoc.info/gems/r_spec/frames)

## Project Goals

* Enforce the guidelines and best practices outlined in the community [RSpec style guide](https://rspec.rubystyle.guide/).
* Provide most of RSpec's DSL to express expected outcomes of a code example without magic power.

## Some Differences

* Less features and an implementation with much less code complexity.
* Spec files can also be executed directly with the `ruby` executable.
* There is no option to activate monkey-patching.
* It does not rely on hacks such as `at_exit` hook to trigger the tests.
* Built-in matchers do not trust _actual_ and do not send it messages.
* If no `subject` has been explicitly determined, none is defined.
* If no described class is set, `described_class` is undefined instead of `nil`.
* Expectations cannot be added inside a `before` block.
* [Arbitrary helper methods](https://relishapp.com/rspec/rspec-core/v/3-10/docs/helper-methods/arbitrary-helper-methods) are not exposed to examples.
* The `let` method defines a helper method rather than a memoized helper method.
* The one-liner `is_expected` syntax also works with block expectations.
* All `subject` definitions must come _before_ examples.
* All `before` definitions must come _before_ examples.
* All `after` definitions must come _before_ examples.
* All `let` definitions must come _before_ examples.

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
gem "r_spec", ">= 1.0.0.beta7"
```

And then execute:

```sh
bundle
```

Or install it yourself as:

```sh
gem install r_spec --pre
```

## Overview

__RSpec clone__ provides a structure for writing executable examples of how your code should behave.

Inspired by [RSpec](https://rspec.info/), it includes a domain specific language (DSL) that allows you to write examples in a way similar to plain english.

A basic spec looks something like this:

[![Super DRY example](https://asciinema.org/a/418672.svg)](https://asciinema.org/a/418672?autoplay=1)

## Usage

### Anatomy of a spec file

To use the `RSpec` module and its DSL, you need to add `require "r_spec"` to your spec files.
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
It has a different name, but behaves exactly like `describe`.

`describe` and `context` take an optional description as argument and a block containing the individual specs or nested groupings.

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

Depending of the project settings, you may run the specs of a project by running `rake spec` (see [`rake` integration example](#rake-integration-example) below).
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

I know that sounds weird, but the [`rspec` command line](https://relishapp.com/rspec/rspec-core/docs/command-line) is also working pretty well:

```sh
rspec spec/my/test/file_spec.rb
rspec spec/my/test/file_spec.rb:42
rspec spec/my/test/
rspec
```

### Spec helper

Many projects use a custom spec helper file, usually named `spec/spec_helper.rb`.

This file is used to require `r_spec` and other includes, like the code from the project needed for every spec file.

### `rake` integration example

The following `Rakefile` settings should be enough:

```ruby
require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.pattern = "spec/**/*_spec.rb"
  t.verbose = true
  t.warning = true
end

task spec: :test
task default: :test
```

## Performance

### Runtime

Benchmark against [100 executions of a file containing one expectation](https://github.com/cyril/r_spec.rb/blob/main/benchmark/) (lower is better).

| Framework   | Seconds to complete |
|-------------|---------------------|
| `r_spec`    | 13.0                |
| `rspec`     | 32.2                |
| `minitest`  | 17.5                |
| `test-unit` | 20.5                |

## Test Suite

__RSpec clone__'s specifications are self-described here: [spec/](https://github.com/cyril/r_spec.rb/blob/main/spec/)

## Contact

* Home page: https://r-spec.dev
* Source code: https://github.com/cyril/r_spec.rb
* Twitter: [https://twitter.com/cyri\_](https://twitter.com/cyri\_)

## Special Thanks ❤️

I would like to thank the whole [RSpec team](https://rspec.info/about/) for all their work.
It's a great framework and it's a pleasure to work with every day.

Without RSpec, this clone would not have been possible.

## Buy me a Coffee ☕

If you like this project please consider making a small donation.

[![Donate with Ethereum](https://github.com/cyril/r_spec.rb/raw/main/img/donate-eth.svg)](https://etherscan.io/address/0x834b5c1feaff5aebf9cd0f25dc38e741d65ab773)

## Versioning

__RSpec clone__ follows [Semantic Versioning 2.0](https://semver.org/).

## License

The [gem](https://rubygems.org/gems/r_spec) is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
