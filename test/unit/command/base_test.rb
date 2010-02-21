require 'test_helper'

class Command::BaseTest < ActiveSupport::TestCase
  should("pass truthitest") { assert true }

  should("register subclassese as commands") do
    Class.new(Command::Base) do |klass|
      def klass.name; 'SpecialCommand' end
    end

    assert Command.defined?('special_command'), "Should have defined the custom 'special_command' command. Space: #{Command.command_space.inspect}"
  end

  context "#to_json" do
    should("include command's output") do
      stub( command = Command::Base.new).output.returns 'Hello world'
      assert_not_nil(json = ActiveSupport::JSON.decode(command.to_json), "Expeting some json")

      assert_equal 'Hello world', json['output'], "Wrong output. JSON: #{json.inspect}"
    end

    should("include command's prompt") do
      stub( command = Command::Base.new ).prompt.returns 'Enter stuff here:'

      assert_not_nil(json = ActiveSupport::JSON.decode(command.to_json), "Expecting json")

      assert_equal 'Enter stuff here:', json['prompt'], "Wrong prompt. JSON: #{json.inspect}"
    end
  end
end
