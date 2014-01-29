class Event < ActiveRecord::Base
  
  default_scope order('event_date ASC')
  
  attr_accessible :hours, :minutes, :production_id, :venue_id, :venue_name, :venue_address, :date, :time
  attr_accessor :venue_name, :venue_address, :date, :time
  
  belongs_to :production
  belongs_to :venue
    
  after_initialize :set_datetime
 
  validates_presence_of :event_date
  validates_presence_of :venue_id
  
  def initialize(params, options = {})
    super
    transform params
  end
  
  def update_attributes(params)
    transform params 
    super  
  end
  
  private
  
  def transform(params)
    self.venue = handle_new_venue params unless params['venue_name'].blank?
    self.event_date = handle_date params unless params['date'].blank? || params['time'].blank?
  end
  
  def set_datetime
    self.date = self.event_date.strftime(date_format) if self.event_date
    self.time = self.event_date.strftime(time_format) if self.event_date
  end
  
  def date_format
    '%e %B, %Y'
  end
  
  def time_format
    '%l:%M %p'
  end 
  
  def datetime_format 
    date_format + ' ' + time_format  
  end
  
  def handle_new_venue(params = {})
    params.delete('venue_id')
    new_venue = Venue.where(name: params[:venue_name]).first
    if (new_venue.nil?) then new_venue = Venue.new(name: params['venue_name'], address: params['venue_address'])
                        else new_venue.update_attributes(name: params['venue_name'], address: params['venue_address']) end
    new_venue if new_venue.save!
  end
  
  def handle_date(params = {})
    params.delete('event_date')
    DateTime.strptime("#{params['date']} #{params['time']}", datetime_format)
  end
  
end
