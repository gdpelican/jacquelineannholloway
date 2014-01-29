class SocialsController < ProtectedController

  # GET /pictures/new
  # GET /pictures/new.json
  def new
    @social = Social.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @social }
    end
  end

  # GET /pictures/1/edit
  def edit
    @social = Social.find(params[:id])
  end

  # POST /pictures
  # POST /pictures.json
  def create
    
    @social = Social.new(params[:social])

    respond_to do |format|
      if @social.save
        format.html { redirect_to @social, notice: 'Social was successfully created.' }
        format.json { render json: @social, status: :created, location: @social }
      else
        format.html { render action: "new" }
        format.json { render json: @social.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.json
  def update

    @social = Social.find(params[:id])

    respond_to do |format|
      if @social.update_attributes(params[:social])
        format.html { redirect_to '/', notice: 'Social was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @social.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @social = Social.find(params[:id])
    @social.destroy

    respond_to do |format|
      format.html { redirect_to '/' }
      format.json { head :no_content }
    end
  end
end
