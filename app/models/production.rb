class Production < ActiveRecord::Base
  
  attr_accessible :name, :address, :picture, :blurb, :description, :duration, :events_attributes, :ticket_link, :info_link
  
  validates_presence_of :name
  validates_presence_of :description
  
  scope :upcoming_productions, ->(upcoming) {  joins(:events)
                                              .where('event_date > ? AND event_date < ?', Date.today, Date.today + upcoming.week )
                                              .uniq }
  
  has_many :events, :dependent => :destroy, :before_add => :set_event_parent
  accepts_nested_attributes_for :events, :reject_if => :all_blank, :allow_destroy => true
  
  alias :update_production_attributes :update_attributes
  
  has_attached_file :picture,
     :styles => { :original => ["1024x1024", :jpeg], :thumb => ["250x250", :jpeg], :tiny => ["100x100#", :jpeg], :profile => ["200x170#", :jpeg] },
     :storage => :s3,
     :default_url => '/assets/missing.png',
     :s3_credentials => "#{Rails.root}/config/s3.yml",
     :path => "/:style/:id/:filename",
     :bucket => 'JaxHolloway-TEST'
  
  def update_attributes(params)
    event_params(params).each do |event|
        accessible_params = event.select { |key, value| Event.accessible_attributes.to_a.include?(key) }.merge({ production_id: self.id })
        
        if (event[:id] && event[:_destroy].to_b) #destroy
          Event.find(event[:id]).destroy
        elsif (event[:id])                  #update
          Event.find(event[:id]).update_attributes(accessible_params)
        else                                #create
          Event.new(accessible_params).save!
        end
    end
    update_production_attributes(params)
  end
  
  def self.current
     upcoming = Event.where("event_date > ?", Time.new).order('event_date ASC')
    if (upcoming.any?)
      upcoming.first.production
    elsif Event.any?
      Event.last(order: :event_date).production
    else
      nil
    end
  end
  
  def self.upcoming(weeks = 4)
    self.upcoming_productions(weeks).sort { |a, b| a.start_at <=> b.start_at }
  end
  
  def start_at
    self.events.minimum(:event_date)
  end
  
  def end_at
    self.events.maximum(:event_date)
  end
  
  def next_date
    upcoming = self.events.where('event_date > ?', Time.new).order('event_date ASC')
    if (upcoming.any?)
      upcoming.first.event_date
    else
      end_at
    end
  end
  
  private
  
  def set_event_parent(event)
    event.production ||= self
  end
  
  def event_params(params)
    events = []
    params.delete('events_attributes').each do |event| events << event[1] end
    events
  end
  
end