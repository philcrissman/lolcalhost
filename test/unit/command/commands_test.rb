require 'test_helper'

class Command::CommandsTest < ActiveSupport::TestCase
  should("pass truthitest") { assert true }

  should("have #output return all current commands sorted by name") do
    assert_match Regexp.new(Command.commands.sort.join('.*')), Command::Commands.new.output
  end
end
