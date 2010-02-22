class CommandsController < ApplicationController
  def create
    if @command = Command.parse(params[:command])
      respond_to do |f|
        f.js { render :json => @command.to_json }
      end
    else
      logger.debug "Unknown command: #{params[:command]}. Command space: #{Command.command_space.inspect}"
      respond_to do |f|
        f.js { render :text => "Unknown command: #{params[:command]}", :status => :not_found }
      end
    end
  end
end
