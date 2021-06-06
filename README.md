# RSpec clone

A minimalist __[RSpec](https://github.com/rspec/rspec) clone__ with all the essentials.

![What did you expect?](https://github.com/cyril/r_spec.rb/raw/main/img/what-did-you-expect.svg)

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
gem "r_spec", ">= 1.0.0.beta3"
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
A domain specific language allows you to write them in a way similar to natural language.

A basic spec looks something like this:

```ruby
require "r_spec"

RSpec.describe Array do
  describe "#size" do
    it "correctly reports the number of elements in the Array" do
      expect([1, 2, 3].size).to eq 3
    end
  end

  describe "#empty?" do
    it "is empty when no elements are in the array" do
      expect([].empty?).to be_true
    end

    it "is not empty if there are elements in the array" do
      expect([1].empty?).to be_false
    end
  end
end
```

It can be executed with the command `ruby array_spec.rb`:

```txt
array_spec.rb:5 Success: expected to eq 3.
array_spec.rb:11 Success: expected true to be_true.
array_spec.rb:15 Success: expected false to be_false.
```

Test files are structured by use of the `describe` or `context` methods. Typically a top level `describe` defines the outer unit (such as a class) that is to be tested by the spec. Further `describe` calls can be nested within the outer unit to specify smaller units under test (such as individual methods). `describe` can also be used to set up a certain context - think empty [Array](https://ruby-doc.org/core-3.0.1/Array.html) versus Array with elements. The `context` method behaves just like the `describe` method and may be used instead, to emphasize context to the reader.

Within a `describe` block, concrete test cases are defined with `it`. A descriptive string can be supplied to `it` describing what the test case tests specifically.

Specs then use the `expect` method to verify that the expected value is returned. See the example above for details.

By convention, specs live in the `spec/` directory of a project. You can run the specs of a project by running `rake spec` (see [Rake integration example](#label-Rake+integration+example)), or a single file with `ruby`.

```sh
# Run all specs in files matching spec/**/*_spec.rb
bundle exec rake spec

# Run a single file
ruby spec/my/test/file_spec.rb
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
module RSpec::Sandbox
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
module RSpec::Sandbox
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
module RSpec::Sandbox
  class Test3582143298
    # main describe block
  end

  class Test198623541 < Test3582143298
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
module RSpec::Sandbox
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
module RSpec::Sandbox
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
module RSpec::Sandbox
  class Test3582143298
  end
end

example = Class.new(RSpec::Sandbox::Test3582143298) { include ExpectationHelper }
example.new.instance_eval { ExpectationTarget::Value.new(41.next).to be(42) }
```

```txt
Success: expected to be 42.
```

## Rake integration example

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

## Test suite

__RSpec clone__'s specifications are self-described here: [spec/](https://github.com/cyril/r_spec.rb/blob/main/spec/)

[![asciicast](https://asciinema.org/a/418565.svg)](https://asciinema.org/a/418565?autoplay=1)

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
