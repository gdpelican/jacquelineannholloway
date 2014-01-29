 class EventsController < ProtectedController
   
    # GET /events/1
    # GET /events/1.json
    def show
      @event = Event.find(params[:id])
      @authed = session[:id]

      respond_to do |format|
        format.js
        format.json { render json: @event }
      end
    end
    
end
