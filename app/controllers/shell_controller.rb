class ShellController < ApplicationController
  include ActionView::Helpers
  
  def index
    respond_to do |format|
      format.js {
        if params[:command]
          @make_safe = h(params[:command])
          @result = parse(@make_safe)
          render :json => { :result => auto_link("lolcalhost:~ $ #{@make_safe}<br/>#{@result}<br/>") }.to_json
        end
      }
      format.html {
        # this needs to be here so the view will display when it's first visited.
      }
    end
    
  end
  
  def parse(cmd)
    args = cmd.split(" ");
    command = args.shift
    case command
    when "lolcalhost"
      "true"
    else
      if self.respond_to?(command)
        self.send(command, args)
      else 
        "-rash: #{command}: command not found"
      end
    end
  end
  
  def useradd(args)
    if args.empty?
      return "Usage: useradd username"
    else
      #todo
      # render :template => 'users/new' ## maybe?
    end
  end
  
  def clear(args)
    if args.empty?
      return "<script>$('.result').empty();</script>"
    else
      return "Usage: clear<br/>Clears the console."
    end
  end
  
  def passwd(args)
    if args.empty?
      return "Usage: passwd<br/>Change your password"
    else
      # todo
    end
  end
  
  def login(args)
    if args.empty?
      return "Usage: login<br/>Login to the system"
    else
      # todo
    end
  end
  
  def su(args)
    if args.empty?
      return "You're kidding, right?"
    else
      return "Nope"
    end
  end
  
  def sudo(args)
    if args.empty?
      return "Usage: don't"
    else
      return "Oh no you didn't"
    end
  end
  
  def pwd(args)
    if args.empty?
      # todo
      return "~"
    else
      return "Usage: pwd"
    end
  end
  
  def ls(args)
    if args.empty?
      return "This should show... something."
    else
      return "Usage: ls"
    end
  end
  
  def help(args)
    if args.empty?
      return <<-EOM
      lolcalhost, version 0.0.1<br/>
      These shell commands are defined internally. Type `help' to see this list.<br/>
      Type `help name' to find out more about the function `name'.<br/>
      <br/>
      ls&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;list the contents of this directory.<br/>
      help&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;display this help message.<br />
      pwd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;print current working directory.<br/>
      clear&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;clear the screen<br/>
      useradd&nbsp;&nbsp;&nbsp;add a user; not yet implemented<br/>
      passwd&nbsp;&nbsp;&nbsp;&nbsp;change your password; not yet implemented<br/>
      login&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;login to the system; not yet implemented
      EOM
    elsif self.respond_to?(args[0].to_sym)
      cmd = args.shift
      return (cmd == "pwd" || cmd == "ls" || cmd == "clear") ? self.send(cmd, "help") : self.send(cmd, args)
    else
      return "No help found for #{args[0]}"
    end
  end
end
