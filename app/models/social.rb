class Social < ActiveRecord::Base
  
  attr_accessible :js_function, :link, :name, :icon, :icon_name
  
  validates_presence_of :name 
  validates_presence_of :link
  
  has_attached_file :icon,
     :styles => {
       :thumb  => "250x250",
       :tiny => "100x100",
       :icon => "32x32"},
     :storage => :s3,
     :s3_credentials => {
       :access_key_id => ENV['S3_KEY'],
       :secret_access_key => ENV['S3_SECRET']
     },
     :path => "/:style/:id/:filename",
     :bucket => 'JaxHolloway-TEST'
  
  def self.get(name)
    Social.where(name: name).first
  end
  
end
