class Command::List < Command::Base
  def output
    "Known commands:\n#{Command.commands.sort.join("\n")}"
  end
end
