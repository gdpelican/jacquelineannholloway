class CalendarController < ApplicationController
      
  def index    
  
    params[:year] = params[:year].nil? ? Date.today.year : params[:year].to_i
    params[:month] = params[:month].nil? ? Date.today.month : params[:month].to_i

    respond_to do |format|
      format.html #show.html.erb
      format.js #show.html.erb
    end
  end
  
end