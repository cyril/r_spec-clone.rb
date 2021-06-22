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
```

### Before/after

```ruby
before do
  # before each test
end

after do
  # after each test
end
```

### Subjects

```ruby
subject { CheckingAccount.new }
it { is_expected.to be_empty }
```

### Lets

```ruby
let(:email) { "contact@bob.email" }
it { expect(email).to eq "contact@bob.email" }
```

### Pending

```ruby
pending { I will implement this later }
```

## Expectations

```ruby
expect(actual).to eq expected
expect(actual).not_to eq expected
```

### Equivalence

```ruby
expect(actual).to eql(expected) # passes if expected.eql?(actual)
expect(actual).to eq(expected)  # passes if expected.eql?(actual)
```

### Identity

```ruby
expect(actual).to equal(expected) # passes if expected.equal?(actual)
expect(actual).to be(expected)    # passes if expected.equal?(actual)
```

### Regular expressions

```ruby
expect(actual).to match(expected) # passes if expected.match?(actual)
```

### Expecting errors

```ruby
expect { actual }.to raise_exception(expected) # passes if expected exception is raised
```

### Truth

```ruby
expect(actual).to be_true # passes if true.equal?(actual)
```

### Untruth

```ruby
expect(actual).to be_false # passes if false.equal?(actual)
```

### Nil

```ruby
expect(actual).to be_nil # passes if nil.equal?(actual)
```

### Type/class

```ruby
expect(actual).to be_instance_of(expected)    # passes if expected.equal?(actual.class)
expect(actual).to be_an_instance_of(expected) # passes if expected.equal?(actual.class)
```
