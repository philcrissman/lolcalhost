require 'test_helper'

class CommandTest < ActiveSupport::TestCase
  class TestCommand < Command::Base
  end
  
  should("pass truthitest") { assert true }

  context "registering a command" do
    should("drop the namespace") do
      assert Command.defined?('test_command'), "Expected 'test_command' to be in command space. Command space: #{Command.command_space.inspect}"
    end
  end

  context "Command.parse" do
    should("lookup the command from the registered commands cache") do
      command = Command.parse('test_command')

      assert_equal [], command.args, "Should report [] if no arguments is specified"
      assert command.is_a?(TestCommand), "Expected to be a TestCommand instance, but wasn't. Class: #{command.class.inspect}"
    end

    should("return nil for unknown command") do
      assert_nil Command.parse('unknowncommand')
    end
  end
end
