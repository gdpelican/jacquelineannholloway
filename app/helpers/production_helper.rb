module ProductionHelper
  
  def production_timespan(production)
    return unless production.start_at and production.end_at
    
    if Time.at(production.start_at) === Time.at(production.end_at)
      year_format(production.start_at)
    elsif (production.start_at.year == production.end_at.year and production.start_at.month == production.end_at.month)
      "#{month_format(production.start_at)} to #{date_format(production.end_at)}"
    elsif (production.start_at.year == production.end_at.year)
      "#{month_format(production.start_at)} to #{year_format(production.end_at)}" 
    else
      "#{year_format(production.start_at)} to #{year_format(production.end_at)}"
    end
  end
  
  private
  
  def year_format(date)
    date.strftime("%b #{date.day.ordinalize}, %Y")
  end
  
  def month_format(date)
    date.strftime("%b #{date.day.ordinalize}")
  end
  
  def date_format(date)
    date.strftime("#{date.day.ordinalize}, %Y")
  end
  
end