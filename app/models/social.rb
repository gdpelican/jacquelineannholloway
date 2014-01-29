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
     :s3_credentials => "#{Rails.root}/config/s3.yml",
     :path => "/:style/:id/:filename",
     :bucket => 'JaxHolloway-TEST'
  
  def self.get(name)
    Social.where(name: name).first
  end
  
end
