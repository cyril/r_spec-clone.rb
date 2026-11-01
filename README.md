# RSpec clone <img src="https://github.com/cyril/r_spec-clone.rb/raw/main/img/logo.svg" style="height: 1em; width: 1em" />

[![Version](https://img.shields.io/github/v/tag/cyril/r_spec-clone.rb?label=Version&logo=github)](https://github.com/cyril/r_spec-clone.rb/tags)
[![Yard documentation](https://img.shields.io/badge/Yard-documentation-blue.svg?logo=github)](https://rubydoc.info/github/cyril/r_spec-clone.rb/main)
[![Ruby](https://github.com/cyril/r_spec-clone.rb/workflows/Ruby/badge.svg?branch=main)](https://github.com/cyril/r_spec-clone.rb/actions?query=workflow%3ARuby+branch%3Amain)
[![License](https://img.shields.io/github/license/cyril/r_spec-clone.rb?label=License&logo=github)](https://github.com/cyril/r_spec-clone.rb/raw/main/LICENSE.md)

A minimalist clone of [RSpec](https://rspec.info/): the words of its language, `describe`, `context`, `it`, `its`, `let`, `subject`, `before`, `expect`, `is_expected`, `pending`, with a few matchers, and nothing else. The differences are deliberate: no monkey patch, no `at_exit` hook, no memoization, no `after`, a child process per `context`, the expected value always on the receiving end of a comparison, and a run that stops at the first expectation that is not met. What it does, it does in about 250 lines, on the testing libraries of [Fixrb](https://fixrb.dev/).

![What did you RSpec?](https://github.com/cyril/r_spec-clone.rb/raw/main/img/what-did-you-rspec.jpg)

## Installation

```ruby
# Gemfile
gem "r_spec-clone"
```

RSpec clone requires Ruby 3.3 or later on a system with `fork`, and depends on [Defi](https://github.com/fixrb/defi), [Matchi](https://github.com/fixrb/matchi) and [Spectus](https://github.com/fixrb/spectus).

## Usage

A spec file requires `r_spec`, and its examples run as the file loads:

```ruby
# spec/duck_spec.rb
require "r_spec"

class Duck
  def walk = "Klop klop!"
  def swim = "Swoosh..."
end

RSpec.describe Duck do
  subject { described_class.new }

  its(:walk) { is_expected.to eq "Klop klop!" }
  its(:swim) { is_expected.to eq "Swoosh..." }

  context "when asked to speak" do
    its(:speak) { is_expected.to raise_exception NoMethodError }
  end

  it "walks before it swims" do
    expect(subject.walk).to match(/Klop/)
    expect { subject.swim }.not_to raise_exception StandardError
  end

  pending "flies"
end
```

```console
$ ruby spec/duck_spec.rb
spec/duck_spec.rb:12: Success: expected "Klop klop!" to eq "Klop klop!"
spec/duck_spec.rb:13: Success: expected "Swoosh..." to eq "Swoosh..."
spec/duck_spec.rb:16: Success: expected #<NoMethodError: undefined method 'speak' for an instance of Duck> to raise exception NoMethodError
spec/duck_spec.rb:20: Success: expected "Klop klop!" to match /Klop/
spec/duck_spec.rb:21: Success: expected "Swoosh..." not to raise exception StandardError
spec/duck_spec.rb:24: Pending: flies
```

The [wiki](https://github.com/cyril/r_spec-clone.rb/wiki) has more examples, each one a file to run, a cheat sheet, and what to write instead of what RSpec has.

### Example groups

`RSpec.describe` opens an example group; `describe` and `context` nest groups inside it. A group is a class, a nested group a subclass of it: what `let`, `subject` and `before` define in a group, the groups inside it inherit, and may redefine with `super` at hand. The first argument of `describe` is a description, or the module under test, which `described_class` then returns; where no enclosing `describe` names a module, `described_class` raises `RSpec::Clone::Error::UndefinedDescribedClass`.

A `context` runs its specs in a child process, forked from the one that loads the file: what they change in the Ruby process, a constant, a global, the object a `subject` memoized by hand, stays in the child. The parent waits for the child, and exits with the status 1 when the child did not succeed.

### Helpers

`let(:name) { … }` defines a private method of the group, called each time it is used: nothing is memoized, so a `let` that must give the same object twice keeps it in an instance variable. The block takes parameters, as a method does. `subject { … }` is `let(:subject)`. The name `initialize`, kept for `before`, and the words of an example, `expect`, `is_expected` and the matchers, which the helper could not reach, raise `RSpec::Clone::Error::ReservedMethod`.

`before { … }` runs before each example of the group, after the blocks of the enclosing groups and those written before it in the group, in the example itself: an instance variable set there is seen by the example and by the helpers it calls.

### Examples

`it("description") { … }` runs its block in a new example at once, in the order of the file: an example is an instance of a class of its own, under the group, where `expect`, `is_expected` and the matchers are words. `its(:name, *arguments) { … }` does the same for one attribute of the subject: `is_expected` there wraps `name`, sent to `subject` with the arguments when the matcher asks for it, so that what it raises can be expected too. `pending "description"` writes a line and runs nothing. Where no enclosing group defines a `subject`, `subject` raises `RSpec::Clone::Error::UndefinedSubject`.

`expect(value)` wraps a value; `expect { … }` wraps a block, called when the matcher asks for its value, so that an exception can be expected; `is_expected` is `expect { subject }`. Then `to(matcher)` passes when the matcher matches, `not_to(matcher)` when it does not, and the result is written at once. An expectation that is not met ends the process: the rest of the file would run on a false premise.

### Matchers

Every matcher is one of [Matchi](https://github.com/fixrb/matchi), and the expected value is the one that receives the comparison: an actual value that lies about `==`, `eql?` or `equal?` cannot pass.

| Matcher | Passes when |
|---|---|
| `eq(expected)`, `eql(expected)` | `expected.eql?(actual)`, and `actual` is of the class of `expected` |
| `be(expected)`, `equal(expected)` | `expected.equal?(actual)` |
| `be_true`, `be_false`, `be_nil` | `actual` is that very object |
| `be_an_instance_of(klass)` | `klass` is the class of `actual` |
| `be_a_kind_of(mod)` | `actual` is an instance of `mod` or of a descendant |
| `be_within(delta).of(expected)` | `(expected - actual).abs <= delta`, for an `Integer`, a `Float`, a `Rational` or a `BigDecimal` |
| `match(regexp)` | `regexp` matches `actual`, a `String` or a `Symbol` |
| `raise_exception(klass, message = nil)` | the block raises an instance of `klass`, with that message (a `String` to equal, or a `Regexp` to match) |
| `satisfy { \|actual\| … }` | the block answers `true`; a `TypeError` for anything but `true` or `false` |
| `be_xxx(*arguments)` | `actual.xxx?(*arguments)` answers `true`; a `TypeError` for anything but `true` or `false` |
| `have_xxx(*arguments)` | `actual.has_xxx?(*arguments)` answers `true`, likewise |
| `change(object, :method).by(delta)` | `object.method` changed by `delta` across the block |
| `change(object, :method).by_at_least(delta)` | changed by `delta` or more |
| `change(object, :method).by_at_most(delta)` | changed by `delta` or less |
| `change(object, :method).from(old).to(new)` | was `old`, became `new` |
| `change(object, :method).to(new)` | became `new`, from something else |

`be_xxx` and `have_xxx` are any name that starts with `be_` or `have_` and goes on with a letter; `klass` and `mod` can also be given by name.

A matcher is any object with `match?`, which takes the block giving the actual value and answers `true` or `false`, and `to_s`, which describes it: `to` and `not_to` take it as it is. So a specification of [Fix](https://github.com/fixrb/fix) is a matcher through [matchi-fix](https://github.com/fixrb/matchi-fix), and a `let` with a parameter gives it a word:

```ruby
require "r_spec"
require "fix"
require "matchi/fix"

Fix :Duck do
  on(:quack) { it MUST eq "Quack!" }
end

class Duck
  def quack = "Quack!"
end

RSpec.describe Duck do
  let(:fix) { |name| Matchi::Fix.new(name) }

  it { expect(Duck.new).to fix(:Duck) }
  it { expect(Object.new).not_to fix(:Duck) }
end
```

## Running specs

A spec file is a Ruby file: `ruby spec/duck_spec.rb` runs it, and its status is 0 when every expectation was met, 1 otherwise. An `exit` reached outside the block of an expectation, in a `before`, a `let`, the body of an `it` or a value given to `expect`, ends the run with its own status, as in RSpec, or the child of a `context`, whose status the parent reads: only `expect { … }`, `is_expected` and `its` judge it. A project runs its files with a Rake task:

```ruby
# Rakefile
require "rake/testtask"

Rake::TestTask.new do |t|
  t.pattern = File.join("spec", "**", "*_spec.rb")
end

task spec: :test
task default: :test
```

The files then load one after the other in one process, so a spec helper, `spec/spec_helper.rb` say, that requires `r_spec` and the code under test is the usual way to share what every file needs.

## Report

For each expectation, one line: its location in the file, the outcome, and the summary of [Spectus](https://github.com/fixrb/spectus), `expected ACTUAL to DESCRIPTION`, with `not` for a negation, or `CLASS: MESSAGE` for an exception that the matcher did not expect. A line break in either is written `\n`. A pending example gives `LOCATION: Pending: DESCRIPTION`.

```ruby
# spec/account_spec.rb
require "r_spec"
require_relative "../lib/account"

RSpec.describe Account do
  subject { described_class.new(100) }

  its(:balance) { is_expected.to eq 100 }
  pending "pays interest"
  its(:withdraw, 500) { is_expected.to raise_exception ArgumentError }
  its(:withdraw, 500) { is_expected.to eq(-400) }
  its(:balance) { is_expected.to eq 200 }
end
```

```console
$ ruby spec/account_spec.rb
spec/account_spec.rb:8: Success: expected 100 to eq 100
spec/account_spec.rb:9: Pending: pays interest
spec/account_spec.rb:10: Success: expected #<ArgumentError: insufficient funds> to raise exception ArgumentError
spec/account_spec.rb:11: Error: ArgumentError: insufficient funds
  /home/alice/account/lib/account.rb:9:in 'Account#withdraw'
  spec/account_spec.rb:11:in 'block (2 levels) in <main>'
  spec/account_spec.rb:11:in 'block in <main>'
  spec/account_spec.rb:5:in '<main>'
```

A success goes to the standard output. A failure, when the matcher answered the wrong way, and an error, when the block raised something the matcher did not expect, go to the standard error, the error with the frames of its backtrace that are not in RSpec clone, Defi, Matchi or Spectus, and end the process with the status 1: here, the last expectation never runs. Nothing else is written: no letter, no colour, no count.

## Differences from RSpec

Some of RSpec is left out on purpose; the rest works as written above. If you come from RSpec, these will surprise you:

- Nothing is monkey-patched, nothing runs from an `at_exit` hook: the examples run as the file loads, in its order, and there is no `rspec` command, no filter, no random order, no formatter.
- The run stops at the first expectation that is not met.
- `let` and `subject` are plain methods, called each time: no memoization, no `let!`, no `subject!`. Definitions must precede the examples that use them, as in a class.
- `before` is the only hook: no `after`, no `around`, no `before(:all)`.
- `subject` and `described_class` are undefined, not `nil`, until a group defines them.
- `its` is built in, and its argument is a Symbol, followed by the arguments of the method.
- A `context` runs in a child process; a `describe` does not.
- `expect` takes a value or a block, never both, and `to` takes a matcher object: no block form of `change`, no `and`, `or`, `all`, `not_to raise_error` without a class, no custom matcher DSL. A matcher is any object with `match?` and `to_s`.
- `eq` is RSpec's `eql`: `1` is not `1.0`. `match` takes a `Regexp` only. `raise_exception` is `raise_error`, and requires an exception class, or its name; it does not rescue an `Interrupt`, a signal, a `NoMemoryError` or the exception with which an enclosing `Timeout` ends its block, unless that is the class expected. `be_truthy`, `be_falsey`, `include`, `start_with`, `respond_to` and the rest do not exist, and `be_a(klass)` is the predicate `a?`, which no object has: `be_true`, `be_false`, `be_a_kind_of`, a predicate or `satisfy` say it.
- A predicate matcher calls a public method of the actual value, and that method must answer `true` or `false`.
- `change(object, :method).to(new)` demands a change, and `change` raises a `TypeError` when the observed method returns the same unfrozen object twice: observe a value, not the mutated object.

## Changes in 2.0

- Built on [Spectus](https://github.com/fixrb/spectus) 6 and [Matchi](https://github.com/fixrb/matchi) 6, with [Defi](https://github.com/fixrb/defi) 4 for `its`, in place of test_tube and expresenter: every expectation is a MUST of Spectus, judged as Fix 1.0 judges its own. Ruby 3.3 or later.
- The report is one line per expectation, `LOCATION: OUTCOME: SUMMARY`, where the location is the line of the expectation, not of the example, and the summary is Spectus', with the actual value and without a final period; the frames of an error follow it. No colour, no emoji. A pending example reads `Pending`, not `Warning`. The standard output is flushed before a failure is written on the standard error.
- An exception the matcher did not expect is an error, written with its class and message and followed by its frames. An `Interrupt`, a signal or a `NoMemoryError` raised in the block goes through, where 1.x made it an error.
- `be_a_kind_of` is a matcher, and `raise_exception` takes an expected message.
- The changes of Matchi 5 and 6 apply: `eq` requires the actual value to be of the class of the expected one, `match` takes a `Regexp` only, `satisfy` and the predicates must answer `true` or `false`, a predicate reaches public methods only, `change … to` requires a change, `change` raises on the same unfrozen object twice, `be_within` subtracts core numbers only, and `raise_exception` lets an `Interrupt`, a signal, a `NoMemoryError` or a `Timeout` go through.
- `describe`, `context`, `before`, `it` and `its` without a block, and `its` with an attribute that is not a Symbol, raise `ArgumentError`. `let` refuses the words of an example, which the helper could not reach. Several `before` in one group run in their order, where 1.x kept the last.
- A child process that the block of an expectation forked and let run on leaves the clone without a word, with `exit!`, instead of writing a result of its own.
- `RSpec::Clone::Error::PendingExpectation`, `RSpec::Clone::Logger`, `RSpec::Clone::ExpectationTarget::Base`, `Block` and `Value`, `RSpec::Clone::ExpectationHelper::Shared` and `Its` are gone: `RSpec::Clone::ExpectationTarget` is one class, `RSpec::Clone::ExpectationHelper::Matcher` holds the matchers, and `RSpec::Clone::Report` writes the lines. The site and the benchmarks are gone from the repository.

## Versioning

RSpec clone follows [Semantic Versioning 2.0](https://semver.org/).

## License

The [gem](https://rubygems.org/gems/r_spec-clone) is available as open source under the terms of the [MIT License](https://github.com/cyril/r_spec-clone.rb/raw/main/LICENSE.md).

## Thanks

To the [RSpec team](https://rspec.info/about/), for the language this clone borrows, and for a framework it is a pleasure to work with every day.
