class ResumeSection < ActiveRecord::Base
  include ResumeChunk

  attr_accessible :parent, :styles, :order, :destroyed
  attr_accessor :destroyed

  has_many :resume_lines, :dependent => :delete_all
  belongs_to :resume
  
  validates_presence_of :resume_id
  validates_presence_of :order
  
  alias_attribute :children, :resume_lines
  alias_attribute :parent, :resume

  default_scope -> { order('"order" ASC') }

  def row_span
    if children.any? then children.first.row_span else 0 end
  end

end