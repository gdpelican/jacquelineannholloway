class Calendar 
  include ActiveModel::Validations
    
  validates_presence_of :year, :month
  
  attr_accessor :year, :month, :boxes, :days, :debug
  
  def initialize(year, month, header = false)
    year = year + ((month-1)/12).to_i
    month = (month-1)%12 + 1
     
    date = Date.new(year, month)
    
    offset = date.wday

    @boxes = Array.new
    @days = Hash.new
    
    while date.month == month
      sub = Array.new
      Date::DAYNAMES.each do |day|
        hash = Hash.new
        if header 
          hash['content'] = day[0,1]
          hash['class'] = 'day-name'
          hash['id'] =  day
        elsif offset > 0 or date.month != month
          hash['content'] = ''
          hash['class'] = 'day empty'
          offset = offset - 1
        else
          hash['content'] = date.day.to_s
          hash['class'] = 'day'
          hash['id'] = 'day_' + date.day.to_s
          @days[date.day] = hash
          date = date.tomorrow
        end
        
        sub.push(hash)
        
      end
      header = false      
      
      @boxes.push(sub)
    end
    
    date = date.yesterday
   
    get_events(date).each do |event|
      
      @days[event.event_date.day]['class'] << ' foreground faded-medium has-event production-' + event.production.id.to_s
      @days[event.event_date.day]['production-name'] = event.production.name
      @days[event.event_date.day]['production-link'] = '/events/' + event.id.to_s
        
    end
    
    @year = year
    @month = month
    
  end
  
  def get_events(date)
    Event.where('(event_date >= ? AND event_date <= ?)', date.beginning_of_month, date.end_of_month+1) 
  end
  
end
