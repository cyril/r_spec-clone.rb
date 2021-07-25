# RSpec clone

A minimalist __RSpec clone__ with all the essentials.

![What did you RSpec?](https://github.com/cyril/r_spec-clone.rb/raw/main/img/what-did-you-rspec.jpg)

## Status

[![Home](https://img.shields.io/badge/Home-r--spec.dev-00af8b)](https://r-spec.dev/)
[![Version](https://img.shields.io/github/v/tag/cyril/r_spec-clone.rb?label=Version&logo=github)](https://github.com/cyril/r_spec-clone.rb/releases)
[![Yard documentation](https://img.shields.io/badge/Yard-documentation-blue.svg?logo=github)](https://rubydoc.info/github/cyril/r_spec-clone.rb/main)
[![CI](https://github.com/cyril/r_spec-clone.rb/workflows/CI/badge.svg?branch=main)](https://github.com/cyril/r_spec-clone.rb/actions?query=workflow%3Aci+branch%3Amain)
[![RuboCop](https://github.com/cyril/r_spec-clone.rb/workflows/RuboCop/badge.svg?branch=main)](https://github.com/cyril/r_spec-clone.rb/actions?query=workflow%3Arubocop+branch%3Amain)
[![License](https://img.shields.io/github/license/cyril/r_spec-clone.rb?label=License&logo=github)](https://github.com/cyril/r_spec-clone.rb/raw/main/LICENSE.md)

## Project goals

1. Keep a low level of code complexity, avoid false negatives and false positives.
2. Translate specification documents into atomic and thread safe Ruby objects.
3. Avoid overloading the interface with additional alternative syntaxes.
4. Provide most of RSpec's DSL to express expected outcomes of a code example.

## Some differences

* There is no option to activate monkey-patching.
* It does not rely on [hacks such as `at_exit` hook](https://blog.arkency.com/2013/06/are-we-abusing-at-exit/) to trigger the tests.
* Malicious _actual values_ cannot [hack results](https://asciinema.org/a/423547?autoplay=1&speed=2).
* If no `subject` has been explicitly determined, none is defined.
* If no described class is set, `described_class` is undefined instead of `nil`.
* Expectations cannot be added inside a `before` block.
* [Arbitrary helper methods](https://relishapp.com/rspec/rspec-core/v/3-10/docs/helper-methods/arbitrary-helper-methods) are not exposed to examples.
* The `let` method defines a helper method rather than a memoized helper method.
* The one-liner `is_expected` syntax also works with block expectations.
* `subject`, `before`, `after` and `let` definitions must come before examples.
* Runs much faster.

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

To use the `RSpec` module and its DSL, you need to add `require "r_spec"` to your spec files.
Many projects use a custom spec helper which organizes these includes.

Concrete test cases are defined in `it` blocks.
An optional descriptive string states it's purpose and a block contains the main logic performing the test.

Test cases that have been defined or outlined but are not yet expected to work can be defined using `pending` instead of `it`. They will not be run but show up in the spec report as pending.

An `it` block contains an example that should invoke the code to be tested and define what is expected of it.
Each example can contain multiple expectations, but it should test only one specific behaviour.

The `its` method can also be used to generate a nested example group with a single example that specifies the expected value (or the block expectations) of an attribute of the subject using `is_expected`.

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

To execute unit tests while isolating side effects in a sub-process, declined methods can be used: `describe!`, `context!`, `it!`, `its!`. Here is an example:

```ruby
app = "foo"

RSpec.describe "Side effects per example" do
  it! "runs the example in isolation" do
    expect { app.gsub!("foo", "bar") }.to eq "bar"
    expect(app).to eq "bar"
  end

  it "runs the example" do
    expect(app).to eq "foo"
  end
end

# Success: expected to eq "bar".
# Success: expected to eq "bar".
# Success: expected to eq "foo".
```

Note: if you are wondering what the Ruby code generated by using the DSL might look like, an article presents the correspondence between each method via simple examples, available in [English](https://dev.to/cyri_/what-ruby-code-to-expect-from-a-testing-dsl-4oe1), [Chinese](https://ruby-china.org/topics/41441) and [Japanese](https://qiita.com/cyril/items/17ee758e162bae144a07).

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

#### Comparisons

```ruby
expect(actual).to be_within(delta).of(expected) # passes if (expected - actual).abs <= delta
```

#### Regular expressions

```ruby
expect(actual).to match(expected) # passes if expected.match?(actual)
```

#### Expecting errors

```ruby
expect { actual }.to raise_exception(expected) # passes if expected exception is raised
```

#### True

```ruby
expect(actual).to be_true # passes if true.equal?(actual)
```

#### False

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

#### Change

```ruby
expect { object.action }.to change(object, :value).from(old).to(new)
expect { object.action }.to change(object, :value).by(delta)
expect { object.action }.to change(object, :value).by_at_least(minimum_delta)
expect { object.action }.to change(object, :value).by_at_most(maximum_delta)
```

#### Satisfy

```ruby
expect(actual).to(satisfy { |value| value == expected })
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

The benchmarks compare the performance of [`r_spec-clone`](https://rubygems.org/gems/r_spec-clone) with the following frameworks (in alphabetical order):

* [`fix`](https://rubygems.org/gems/fix)
* [`minitest`](https://rubygems.org/gems/minitest)
* [`rspec`](https://rubygems.org/gems/rspec)

### Boot time

Benchmark against [100 executions of a file containing 1 expectation](https://github.com/cyril/r_spec-clone.rb/blob/main/benchmark/boot_time/) (lower is better).

![Boot time benchmark](https://r-spec.dev/benchmark-boot-time.svg)

### Runtime

Benchmark against [1 execution of a file containing 1,000,000 expectations](https://github.com/cyril/r_spec-clone.rb/blob/main/benchmark/run_time/) (lower is better).

![Runtime benchmark](https://r-spec.dev/benchmark-run-time.svg)

## Test suite

__RSpec clone__'s specifications are self-described here: [spec/](https://github.com/cyril/r_spec-clone.rb/blob/main/spec/)

## Contact

* Home page: [https://r-spec.dev/](https://r-spec.dev/)
* Cheatsheet: [https://r-spec.dev/cheatsheet.html](https://r-spec.dev/cheatsheet.html)
* Blog post: [https://batman.buzz/introducing-a-new-rspec-850d48c0f901](https://batman.buzz/introducing-a-new-rspec-850d48c0f901)
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
