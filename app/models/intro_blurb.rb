class IntroBlurb < ActiveRecord::Base
  attr_accessible :text, :picture
  
    has_attached_file :picture,
     :styles => {
       :thumb  => "250x250#",
       :tiny => "100x100#"},
     :storage => :s3,
     :s3_credentials => {
       :access_key_id => ENV['S3_KEY'],
       :secret_access_key => ENV['S3_SECRET']
     },
     :path => "/:style/:id/:filename",
     :bucket => 'JaxHolloway-TEST'
end
