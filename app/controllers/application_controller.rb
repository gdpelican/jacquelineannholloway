class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def initialize
    @config = SiteConfiguration.current
    super
  end
  
end