class CommandsController < ApplicationController
  def create
    if @command = Command.parse(params[:command])
      respond_to do |f|
        f.js { render :json => @command.to_json }
      end
    else
      logger.debug "Unknown command: #{params[:command]}. Command space: #{Command.command_space.inspect}"
      respond_to do |f|
        # f.js { render :text => "Unknown command: #{params[:command]}", :status => :not_found }
        # Output wasn't rendering; changing to json works, but does not if status set to not_found...
        # should add test. I like the 404 idea, but it seems to mean that the output doesn't render...
        f.js { render :json => {"output" => "#{params[:command]}: command not found"}.to_json }
      end
    end
  end
end
