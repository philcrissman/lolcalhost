class Command::Base
  attr_reader :args

  def initialize(args = [])
    @args = args
  end

  def self.inherited(subclass)
    Command.register subclass
  end
end
