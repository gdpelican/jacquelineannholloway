class ProtectedController < ApplicationController
  protect_from_forgery
  
  def require_login
    if session[:id].nil? and @contact.nil?
      flash[:error] = 'Please login to continue'
      redirect_to login_path
    end
    true
  end
  
end
