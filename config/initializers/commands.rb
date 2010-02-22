require 'command'

# load all the commands
Dir[File.join(Rails.root, 'app', 'models', 'command', '**')].each { |f| require f }
