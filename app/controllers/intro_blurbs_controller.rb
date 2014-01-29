class IntroBlurbsController < ProtectedController

  layout 'admin'
  
  before_filter :require_login

  # GET /intro_blurbs/new
  # GET /intro_blurbs/new.json
  def new
    @intro_blurb = IntroBlurb.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @intro_blurb }
    end
  end

  # GET /intro_blurbs/1/edit
  def edit
    @intro_blurb = IntroBlurb.find(params[:id])
  end

  # POST /intro_blurbs
  # POST /intro_blurbs.json
  def create
    @intro_blurb = IntroBlurb.new(params[:intro_blurb])

    respond_to do |format|
      if @intro_blurb.save
        format.html { redirect_to :root, notice: 'Intro blurb was successfully created.' }
        format.json { render json: @intro_blurb, status: :created, location: @intro_blurb }
      else
        format.html { render action: "new" }
        format.json { render json: @intro_blurb.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /intro_blurbs/1
  # PUT /intro_blurbs/1.json
  def update
    @intro_blurb = IntroBlurb.find(params[:id])

    respond_to do |format|
      if @intro_blurb.update_attributes(params[:intro_blurb])
        format.html { redirect_to :root, notice: 'Intro blurb was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @intro_blurb.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /intro_blurbs/1
  # DELETE /intro_blurbs/1.json
  def destroy
    @intro_blurb = IntroBlurb.find(params[:id])
    @intro_blurb.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end
end
