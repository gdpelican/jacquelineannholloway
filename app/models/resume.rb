class Resume < ActiveRecord::Base
  include ResumeChunk

  attr_accessible :name, :active

  has_many :resume_sections, :dependent => :delete_all

  scope :active, -> { where(active: true) }
  
  alias_attribute :children, :resume_sections
  
  #method to determine table spacing for pdf printing
  def lcm
    result = 1
    children.each do |child|
      result = result.lcm(child.row_span)
    end
    result
  end

end