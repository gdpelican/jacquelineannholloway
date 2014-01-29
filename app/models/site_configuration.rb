class SiteConfiguration < ActiveRecord::Base
  attr_accessible :profile_picture, :site_primary, :site_primary_rgb, :site_foreground, :upcoming_weeks
  
  has_attached_file :profile_picture,
     :storage => :s3,
     :s3_credentials => "#{Rails.root}/config/s3.yml",
     :path => "/:style/:id/:filename",
     :bucket => 'JaxHolloway-TEST'
 
  def self.current
    SiteConfiguration.where(current: true).first || SiteConfiguration.new
  end
  
  def update_attributes(params)
    if params[:site_primary]
      rgb = Color::RGB.from_html(params[:site_primary])
      params[:site_primary_rgb] = "#{rgb.red.to_i}, #{rgb.green.to_i}, #{rgb.blue.to_i}"
    end
    
    super
  end
 
end
