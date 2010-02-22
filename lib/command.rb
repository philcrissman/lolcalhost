module Command
  class CommandExists < StandardError
    def initialize(name)
      @@name = name
    end

    def to_s; "Command with name #{name} is already defined" end
  end
  
  class << self
    def command_space
      @command_space ||= ::Command::Space.new
    end

    delegate :commands, :register, :to => :command_space

    def parse(command_line)
      (name, *args) = command_line.split(/ +/)

      if command_space.include?(name)
        command_space[name].new args
      else
        nil
      end
    end

    def defined?(command)
      command_space.include?(command)
    end
  end
end

require 'commands'
