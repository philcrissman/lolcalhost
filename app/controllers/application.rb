# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '8a9584ee4929140aa1492dafcd9e8cbf'
  
  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = "-rash: access denied"
        redirect_to new_user_session_url # will need to change this to render the form in the shell view.
        return false
      end
    end
    
    def require_no_user
      if current_user
        store_location
        flash[:notice] = "-rash: you are already logged in"
        redirect_to account_url # TODO, change this
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    
    # this method may not be needed... ?
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end
