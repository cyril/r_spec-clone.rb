# frozen_string_literal: true

class Foo
  def self.call
    42
  end

  module Fooo
  end
end

module Bar
  def self.call
    42
  end
end

module Baz
  def self.call
    42
  end
end
