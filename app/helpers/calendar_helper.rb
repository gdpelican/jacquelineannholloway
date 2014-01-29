module CalendarHelper 
  def get_year
    params[:year].nil? ? Date.today.year : params[:year].to_i
  end
  
  def get_month
    params[:month].nil? ? Date.today.month : params[:month].to_i
  end
  
  def calendar_month_path(year, month)
    calendar_path + '/' + year.to_s + '/' + month.to_s
  end
 
end