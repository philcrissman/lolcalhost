module Command
  class Space
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
end
