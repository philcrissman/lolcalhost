require 'command'

# load all the commands
Dir[File.join(Rails.root, 'app', 'commands', '**')].each { |f| require f }
