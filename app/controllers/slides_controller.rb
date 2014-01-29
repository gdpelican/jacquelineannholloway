class SlidesController < ApplicationController
  # GET /slides
  # GET /slides.json
  def index
    
    @authed = session[:id]
    
    @slides = Slide.all
        
    @intro_blurbs = IntroBlurb.all
    
    @socials = Social.all
    @facebook = Social.get('Facebook')
    @twitter = Social.get('Twitter')
    @email = Social.get('MailChimp')
    
    @resumes = @authed ? Resume.all : Resume.active
    @resume_json = '[' << @resumes.map { |resume| resume.to_json }.join(', ') << ']'
    
    @message = ContactForm.new
    
    @current = Production.current
    @upcoming = Production.upcoming(@config.upcoming_weeks)
    
    @calendar = Calendar.new(Production.current.next_date.year, Production.current.next_date.month) if @current
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @slides }
    end
  end
  
end
