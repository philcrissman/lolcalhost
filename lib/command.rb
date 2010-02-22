module Command
  extend self

  class CommandExists < StandardError
    def initialize(name)
      @@name = name
    end

    def to_s; "Command with name #{name} is already defined." end
  end

  class CommandSpace
    def initialize
      @commands = { }
    end

    def include?(command_name)
      @commands.has_key?(command_name)
    end

    def commands; @commands.keys end

    def [](command_name)
      @commands[command_name]
    end

    def register(command_klass)
      name = command_klass.name.demodulize.underscore

      unless @commands.has_key?(name)
        @commands[name] = command_klass
      else
        raise CommandExists, name
      end
    end
  end
  
  def command_space
    @command_space ||= CommandSpace.new
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

require 'command/commands'
