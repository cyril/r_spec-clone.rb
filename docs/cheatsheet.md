# Cheatsheet for RSpec clone

## Writing tests

```ruby
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

# Success: expected to eq 3.
# Success: expected to be true.
# Success: expected to be false.
```

### Described class

```ruby
RSpec.describe String do
  it { expect(described_class).to be String }
end

# Success: expected to be String.
```

### Before/after

```ruby
RSpec.describe "#before, #after" do
  before do
    # before each test
  end

  after do
    # after each test
  end
end
```

### Subjects

```ruby
RSpec.describe "#subject" do
  subject { [] }
  it { is_expected.to be_empty }
end

# Success: expected [] to be empty.
```

### Context

```ruby
RSpec.context "when divided by zero" do
  subject { 42 / 0 }

  it { is_expected.to raise_exception ZeroDivisionError }
end

# Success: divided by 0.
```

### Lets

```ruby
RSpec.describe "#let" do
  let(:email) { "contact@bob.email" }
  it { expect(email).to eq "contact@bob.email" }
end

# Success: expected to eq "contact@bob.email".
```

### Pending

```ruby
RSpec.pending("not implemented test") { I will add it tonight! }

# Warning: not implemented test.
```

## Expectations

Expectations define if the value being tested (_actual_) matches a certain value or specific criteria.

### Positive expectation

```ruby
RSpec.it { expect("foo").to eq "foo" }

# Success: expected to eq "foo".
```

### Negative expectation

```ruby
RSpec.it { expect("foo").not_to eq "bar" }

# Success: expected "foo" not to eq "bar".
```

## Matchers

### Equivalence

```ruby
RSpec.it "tests two same equivalences" do
  expect("foo").to eq("foo")
  expect("foo").to eql("foo")
end

# Success: expected to eq "foo".
# Success: expected to eq "foo".
```

### Identity

```ruby
RSpec.it "tests two same identities" do
  expect(:foo).to be(:foo)
  expect(:foo).to equal(:foo)
end

# Success: expected to be :foo.
# Success: expected to be :foo.
```

### Comparisons

```ruby
RSpec.it { expect(40).to be_within(2).of(42) }

# Success: expected 40 to be within 2 of 42.
```

### Regular expressions

```ruby
RSpec.it { expect("bob@example.email").to match(/^[^@]+@[^@]+$/) }

# Success: expected "bob@example.email" to match /^[^@]+@[^@]+$/.
```

### Expecting errors

```ruby
RSpec.it "raises a name error" do
  expect { RSpec::Clone::Boom! }.to raise_exception(NameError)
end

# Success: undefined method `Boom!' for RSpec::Clone:Module.
```

### True

```ruby
RSpec.it { expect(true).to be_true }

# Success: expected to be true.
```

### False

```ruby
RSpec.it { expect(false).to be_false }

# Success: expected to be false.
```

### Nil

```ruby
RSpec.it { expect(nil).to be_nil }

# Success: expected to be nil.
```

### Type/class

```ruby
RSpec.it "tests two instances" do
  expect(42).to be_an_instance_of(Integer)
  expect(:foo).to be_instance_of(Symbol)
end

# Success: expected 42 to be an instance of Integer.
# Success: expected :foo to be instance of Symbol.
```

### Predicate

```ruby
RSpec.it "tests two dynamic predicate matchers" do
  expect([]).to be_empty           # passes because `[].empty?` returns `true`
  expect(foo: 1).to have_key(:foo) # passes because `{ foo: 1 }.has_key?(:foo)` returns `true`
end

# Success: expected [] to be empty.
# Success: expected {:foo=>1} to have key :foo.
```

### Change

```ruby
object = "foo"

RSpec.it do
  expect { object.upcase! }.to change(object, :to_s).from("foo").to("FOO")
end

# Success: expected to change from "foo" to "FOO".
```

```ruby
object = "foo"

RSpec.it do
  expect { object.upcase! }.to change(object, :to_s).to("FOO")
end

# Success: expected to change to "FOO".
```

```ruby
object = []

RSpec.it do
  expect { object << 1 }.to change(object, :length).by(1)
end

# Success: expected [1] to change by 1.
```

```ruby
object = []

RSpec.it do
  expect { object << 1 }.to change(object, :length).by_at_least(1)
end

# Success: expected [1] to change by at least 1.
```

```ruby
object = []

RSpec.it do
  expect { object << 1 }.to change(object, :length).by_at_most(1)
end

# Success: expected [1] to change by at most 1.
```

### Satisfy

```ruby
RSpec.it "tests that 42 is equal to itself" do
  expect { 42 }.to(satisfy { |value| value == 42 })
end

# Success: expected 42 to satisfy &block.
```
