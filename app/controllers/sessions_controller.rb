class SessionsController < ApplicationController
  
  before_filter :require_logout, :only => [:new, :create]

  # GET /sessions
  def index
    redirect_to new_session_path
  end

  # GET /sessions/new
  def new
    @session = Session.new
  end

  # POST /sessions
  def create
    @session = Session.new(params[:session])
    if @session.save
      session[:id] = @session.id
      redirect_to root_url, notice: 'Successfully signed in as admin'
    else
      redirect_to login_path, flash: { error: 'Invalid username / password combination' }
    end
  end

  # DELETE /sessions/1
  def destroy
    if session[:id]
      Session.find(session[:id]).destroy
      session[:id] = @user = nil
      flash = { notice: 'Successfully signed out' }
    else
      flash = { error: 'You must be logged in to complete this action' }
    end
    redirect_to root_url, flash: flash
  end

  def require_logout
      redirect_to root_url, flash: { error: 'You must be logged out to complete this action' } if session[:id]
  end

end
