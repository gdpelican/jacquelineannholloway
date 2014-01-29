 class ProductionsController < ProtectedController
    
   layout 'admin'
    
   before_filter :require_login
      
   def index
     @productions = Production.all
     
     respond_to do |format|
       format.html
       format.json { render json: @productions}
     end
   end
   
    # GET /events/1
    # GET /events/1.json
    def show
      @production = Production.find(params[:id])

      respond_to do |format|
        format.html # index.html.erb
        format.js
        format.json { render json: @production }
      end
    end

  # GET /events/new
  # GET /events/new.json
  def new
    @production = Production.new
    @venues = Venue.all
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @production }
    end
  end

  # GET /events/1/edit
  def edit
    @production = Production.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @production = Production.new(params[:production])

    respond_to do |format|
      if @production.save
        format.html { redirect_to @production, notice: 'Production was successfully created.' }
        format.json { render json: @production, status: :created, location: @production }
      else
        format.html { render action: "new" }
        format.json { render json: @production.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @production = Production.find(params[:id])
    
    respond_to do |format|
      if @production.update_attributes(params[:production])
        format.html { redirect_to @production, notice: 'Production was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @production.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @production = Production.find(params[:id])
    @production.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
