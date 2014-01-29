class ResumeLine < ActiveRecord::Base
  include ResumeChunk

  attr_accessible :parent, :styles, :order, :destroyed
  attr_accessor :destroyed

  belongs_to :resume_section
  has_many :resume_items, :dependent => :delete_all

  validates_presence_of :resume_section_id
  validates_presence_of :order
  
  alias_attribute :parent, :resume_section
  alias_attribute :children, :resume_items
  
  default_scope -> { order('"order" ASC') }
  
  def row_span
    if children.any? then children.count else 0 end
  end

end

