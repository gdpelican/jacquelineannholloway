class ResumeController < ProtectedController

  before_filter :ensure_auth, :except => :show 
  before_filter :get_chunk, :except => :create

  def ensure_auth
    @authed = require_login
  end

  def get_chunk
    @chunk = ResumeChunk.get_chunk(params[:level].to_sym, params[:id])
  end

  def show   
    respond_to do |format|
      format.html
      format.json { render json: @chunk }
      format.pdf {
        kit = PDFKit.new(render_to_string action: 'show.html.erb', formats: :html)
        kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/resume_pdf.css"
        send_data(kit.to_pdf, filename: "Jacqueline-Holloway-#{@chunk.name}-Resume.pdf", type: 'application/pdf')
        return }
    end
  end

  def create
    @resume = Resume.create! name: params[:name][:post], active: false
    respond_to do |format|
      format.html { redirect_to :root, notice: "Successfully created resume '#{@resume.name}'" }
      format.json { render json: "New Resume #{@resume.name} created".to_json  }
    end
  end
  
  def update
    if !ResumeChunk.update @chunk, params[:resume] then raise "Resume '#{@chunk.name}' was not saved - please try again." end 

    respond_to do |format|
      format.html
      format.json { render json: "Resume '#{@chunk.name}' was saved successfully.".to_json }
    end
  end

  def destroy
    @chunk.destroy
    redirect_to root_url
  end
  
end