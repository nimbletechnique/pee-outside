# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  include HoptoadNotifier::Catcher
  
  
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_pee_session_id'
  
  helper_method :is_logged_in?
  
  protected
  
  def is_logged_in?
    session[:user]
  end
  
  private
  
  def authorize
    redirect_to :controller=>:admin, :action=>:login unless is_logged_in?
  end
  
  
end
