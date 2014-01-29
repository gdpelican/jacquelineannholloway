class Slide
  
  attr_accessor :index, :view, :title, :background
    
  def self.all
    @@index = 0
    @pages = Array.new
    Dir.foreach(Rails.root + 'app/views/pages/') { |slide| 
      if(slide.starts_with? '_')
        @pages.push(Slide.new(slide))
      end
    }
    
    @@index = 0
    @pages.sort! { |x,y| x.view <=> y.view }.each do |page|
      page.index = @@index += 1
    end
    
    return @pages
  end
  
  def self.all_titles
    @titles = Array.new
    self.all.each do |slide|
      @titles.push(slide.title)
    end
    return @titles
  end
  
  def initialize(slide)
    @view = slide[1..-1][0..-10].downcase
    @title = @view[2..-1].capitalize
    @background = Background.where(slide_title: @title).first
  end
end