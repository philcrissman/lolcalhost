require 'test_helper'

class Commands::BaseTest < ActiveSupport::TestCase
  should("pass truthitest") { assert true }

  should("register subclassese as commands") do
    Class.new(Command::Base) do |klass|
      def klass.name; 'SpecialCommand' end
    end

    assert Command.defined?('special_command'), "Should have defined the custom 'special_command' command. Space: #{Command.command_space.inspect}"
  end
end
