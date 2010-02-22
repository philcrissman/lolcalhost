require 'test_helper'

class Command::ListTest < ActiveSupport::TestCase
  should("pass truthitest") { assert true }

  should("have #output return all current commands sorted by name") do
    assert_match Regexp.new(Command.commands.sort.join('.*'), Regexp::MULTILINE), Command::List.new.output
  end
end
