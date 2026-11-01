# frozen_string_literal: true

require_relative File.join("..", "spec_helper")
require "open3"
require "rbconfig"

# Each fixture is run by a Ruby of its own, from the root of the repository,
# and what it writes, read as UTF-8 whatever the locale, is compared to the
# letter.
RSpec.describe RSpec::Clone::Report do
  let(:root) { File.expand_path(File.join("..", ".."), __dir__) }
  let(:path) { File.join("spec", "report", "fixtures", fixture) }
  let(:run) { Open3.capture3(RbConfig.ruby, "-I", "lib", path, chdir: root) }
  let(:out) { run.fetch(0).force_encoding(Encoding::UTF_8) }
  let(:err) { run.fetch(1).force_encoding(Encoding::UTF_8) }
  let(:status) { run.fetch(2).exitstatus }

  context "when every expectation is met" do
    let(:fixture) { "met.rb" }

    it "writes one line per expectation on the standard output" do
      expect(out).to eq <<~TEXT
        spec/report/fixtures/met.rb:8: Success: expected 42 to be 42
        spec/report/fixtures/met.rb:9: Success: expected 43 to be 43
        spec/report/fixtures/met.rb:11: Pending: is written later
        spec/report/fixtures/met.rb:12: Pending: is written in another encoding: caf\uFFFD
        spec/report/fixtures/met.rb:15: Success: expected #<ZeroDivisionError: divided by 0> to raise exception ZeroDivisionError
        spec/report/fixtures/met.rb:19: Success: expected 42 not to be nil
        spec/report/fixtures/met.rb:20: Success: expected "42" to eq "42"
        spec/report/fixtures/met.rb:24: Success: expected :done to be :done
      TEXT
    end

    it { expect(err).to eq "" }
    it { expect(status).to be 0 }
  end

  context "when an expectation is not met" do
    let(:fixture) { "unmet.rb" }

    it "writes what was met before, then stops" do
      expect(out).to eq "spec/report/fixtures/unmet.rb:6: Success: expected 4 to be 4\n"
    end

    it { expect(err).to eq "spec/report/fixtures/unmet.rb:7: Failure: expected 4 to be 42\n" }
    it { expect(status).to be 1 }
  end

  context "when the block raises" do
    let(:fixture) { "error.rb" }

    it { expect(out).to eq "" }

    it "writes the error on one line, then the frames that are not the clone's" do
      expect(err).to match(/\Aspec\/report\/fixtures\/error\.rb:6: Error: RuntimeError: boom\\nbang\n/)
    end

    it { expect(err.lines.drop(1).size).to be 4 }
    it { expect(err.lines.drop(1).all? { |line| line.start_with?("  spec/report/fixtures/error.rb:") }).to be true }
    it { expect(status).to be 1 }
  end

  context "when exit is reached outside an expectation" do
    let(:fixture) { "exit_outside.rb" }

    it { expect(out).to eq "spec/report/fixtures/exit_outside.rb:6: Success: expected 4 to be 4\n" }
    it { expect(err).to eq "" }
    it { expect(status).to be 3 }
  end

  context "when an expectation of a context is not met" do
    let(:fixture) { "context.rb" }

    it { expect(out).to eq "" }
    it { expect(err).to eq "spec/report/fixtures/context.rb:7: Failure: expected 4 to be 42\n" }
    it { expect(status).to be 1 }
  end

  context "when an expectation of a nested context is not met" do
    let(:fixture) { "nested.rb" }

    it { expect(out).to eq "" }
    it { expect(err).to eq "spec/report/fixtures/nested.rb:8: Failure: expected 4 to be 42\n" }
    it { expect(status).to be 1 }
  end

  context "when the block exits" do
    let(:fixture) { "exit.rb" }

    it "writes a pending message on one line" do
      expect(out).to eq "spec/report/fixtures/exit.rb:6: Pending: is written\\non two lines\n"
    end

    it "judges the exit, with its frames" do
      expect(err.lines.first).to eq "spec/report/fixtures/exit.rb:7: Error: SystemExit: exit\n"
    end

    it { expect(status).to be 1 }
  end
end

# spec/report/output_spec.rb:21: Success: expected "spec/report/fixtures/met.rb:8: Success: expected 42 to be 42\nspec/report/fixtures/met.rb:9: Success: expected 43 to be 43\nspec/report/fixtures/met.rb:11: Pending: is written later\nspec/report/fixtures/met.rb:12: Pending: is written in another encoding: caf�\nspec/report/fixtures/met.rb:15: Success: expected #<ZeroDivisionError: divided by 0> to raise exception ZeroDivisionError\nspec/report/fixtures/met.rb:19: Success: expected 42 not to be nil\nspec/report/fixtures/met.rb:20: Success: expected \"42\" to eq \"42\"\nspec/report/fixtures/met.rb:24: Success: expected :done to be :done\n" to eq "spec/report/fixtures/met.rb:8: Success: expected 42 to be 42\nspec/report/fixtures/met.rb:9: Success: expected 43 to be 43\nspec/report/fixtures/met.rb:11: Pending: is written later\nspec/report/fixtures/met.rb:12: Pending: is written in another encoding: caf�\nspec/report/fixtures/met.rb:15: Success: expected #<ZeroDivisionError: divided by 0> to raise exception ZeroDivisionError\nspec/report/fixtures/met.rb:19: Success: expected 42 not to be nil\nspec/report/fixtures/met.rb:20: Success: expected \"42\" to eq \"42\"\nspec/report/fixtures/met.rb:24: Success: expected :done to be :done\n"
# spec/report/output_spec.rb:33: Success: expected "" to eq ""
# spec/report/output_spec.rb:34: Success: expected 0 to be 0
# spec/report/output_spec.rb:41: Success: expected "spec/report/fixtures/unmet.rb:6: Success: expected 4 to be 4\n" to eq "spec/report/fixtures/unmet.rb:6: Success: expected 4 to be 4\n"
# spec/report/output_spec.rb:44: Success: expected "spec/report/fixtures/unmet.rb:7: Failure: expected 4 to be 42\n" to eq "spec/report/fixtures/unmet.rb:7: Failure: expected 4 to be 42\n"
# spec/report/output_spec.rb:45: Success: expected 1 to be 1
# spec/report/output_spec.rb:51: Success: expected "" to eq ""
# spec/report/output_spec.rb:54: Success: expected "spec/report/fixtures/error.rb:6: Error: RuntimeError: boom\\nbang\n  spec/report/fixtures/error.rb:6:in 'block (3 levels) in <main>'\n  spec/report/fixtures/error.rb:6:in 'block (2 levels) in <main>'\n  spec/report/fixtures/error.rb:6:in 'block in <main>'\n  spec/report/fixtures/error.rb:5:in '<main>'\n" to match /\Aspec\/report\/fixtures\/error\.rb:6: Error: RuntimeError: boom\\nbang\n/
# spec/report/output_spec.rb:57: Success: expected 4 to be 4
# spec/report/output_spec.rb:58: Success: expected true to be true
# spec/report/output_spec.rb:59: Success: expected 1 to be 1
# spec/report/output_spec.rb:65: Success: expected "spec/report/fixtures/exit_outside.rb:6: Success: expected 4 to be 4\n" to eq "spec/report/fixtures/exit_outside.rb:6: Success: expected 4 to be 4\n"
# spec/report/output_spec.rb:66: Success: expected "" to eq ""
# spec/report/output_spec.rb:67: Success: expected 3 to be 3
# spec/report/output_spec.rb:73: Success: expected "" to eq ""
# spec/report/output_spec.rb:74: Success: expected "spec/report/fixtures/context.rb:7: Failure: expected 4 to be 42\n" to eq "spec/report/fixtures/context.rb:7: Failure: expected 4 to be 42\n"
# spec/report/output_spec.rb:75: Success: expected 1 to be 1
# spec/report/output_spec.rb:81: Success: expected "" to eq ""
# spec/report/output_spec.rb:82: Success: expected "spec/report/fixtures/nested.rb:8: Failure: expected 4 to be 42\n" to eq "spec/report/fixtures/nested.rb:8: Failure: expected 4 to be 42\n"
# spec/report/output_spec.rb:83: Success: expected 1 to be 1
# spec/report/output_spec.rb:90: Success: expected "spec/report/fixtures/exit.rb:6: Pending: is written\\non two lines\n" to eq "spec/report/fixtures/exit.rb:6: Pending: is written\\non two lines\n"
# spec/report/output_spec.rb:94: Success: expected "spec/report/fixtures/exit.rb:7: Error: SystemExit: exit\n" to eq "spec/report/fixtures/exit.rb:7: Error: SystemExit: exit\n"
# spec/report/output_spec.rb:97: Success: expected 1 to be 1
