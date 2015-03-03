class Background < ActiveRecord::Base
  
  attr_accessible :slide_title, :picture_alt, :picture, :blurb
  before_create :remove_conflicts
    
  validates_presence_of :slide_title 
  validates_presence_of :picture_alt
  
  has_attached_file :picture,
     :styles => {
       :original => "1024x800",
       :thumb  => "250x250",
       :tiny => "100x100"},
     :storage => :s3,
     :s3_credentials => {
       :access_key_id => ENV['S3_KEY'],
       :secret_access_key => ENV['S3_SECRET']
     },
     :path => "/:style/:id/:filename",
     :bucket => 'JaxHolloway-TEST'

  def remove_conflicts
    Background.where(:slide_title => self.slide_title).each do |conflict|
      conflict.destroy
    end
  end
  
end
