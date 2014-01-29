class BackgroundsController < ProtectedController
  layout 'admin'
  
  before_filter :require_login
  
  # GET /pictures
  # GET /pictures.json
  def index
    @backgrounds = Background.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @backgrounds }
    end
  end

  # GET /pictures/new
  # GET /pictures/new.json
  def new
    @background = Background.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @background }
    end
  end

  # GET /pictures/1/edit
  def edit
    @background = Background.find(params[:id])
  end

  # POST /pictures
  # POST /pictures.json
  def create
    
    @background = Background.new(params[:background])

    respond_to do |format|
      if @background.save
        format.html { redirect_to backgrounds_path, notice: 'Picture was successfully created.' }
        format.json { render json: @background, status: :created, location: backgrounds_path }
      else
        format.html { render action: "new" }
        format.json { render json: @background.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.json
  def update

    @background = Background.find(params[:id])

    respond_to do |format|
      if @background.update_attributes(params[:background])
        format.html { redirect_to root_url, notice: 'Picture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @background.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @background = Background.find(params[:id])
    @background.destroy

    respond_to do |format|
      format.html { redirect_to backgrounds_path }
      format.json { head :no_content }
    end
  end
end
