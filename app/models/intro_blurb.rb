class IntroBlurb < ActiveRecord::Base
  attr_accessible :text, :picture
  
    has_attached_file :picture,
     :styles => {
       :thumb  => "250x250#",
       :tiny => "100x100#"},
     :storage => :s3,
     :s3_credentials => "#{Rails.root}/config/s3.yml",
     :path => "/:style/:id/:filename",
     :bucket => 'JaxHolloway-TEST'
end
