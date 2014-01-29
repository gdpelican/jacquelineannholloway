class ResumeItem < ActiveRecord::Base
  include ResumeChunk

  attr_accessible :parent, :text, :order

  belongs_to :resume_line
  
  validates_presence_of :resume_line_id
  validates_presence_of :order
  
  alias_attribute :parent, :resume_line
  
end
