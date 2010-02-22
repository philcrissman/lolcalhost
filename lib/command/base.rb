class Command::Base
  attr_reader :args

  attr_reader :output, :prompt

  def initialize(args = [])
    @args = args
  end

  def self.inherited(subclass)
    Command.register subclass
  end

  def to_json
    { :output => output, :prompt => prompt }.to_json
  end
end
