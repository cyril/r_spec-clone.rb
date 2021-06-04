# frozen_string_literal: true

require_relative File.join("..", "spec_helper")

RSpec.describe RSpec::DSL do
  subject { self.class.superclass }

  it "outputs some messages to the console" do
    log("the described class is #{described_class.inspect}")
    log("the subject is #{subject.inspect}")
  end
end
