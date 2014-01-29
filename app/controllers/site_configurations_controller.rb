class SiteConfigurationsController < ApplicationController

  def update
    @config = SiteConfiguration.current
    
    respond_to do |format|
      if @config.update_attributes(params[:site_configuration])
        format.html { redirect_to :root, notice: 'Configuration successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to :root, error: "Configuration updates unable to be processed: #{@config.errors}" }
        format.json { render json: @profile_image.errors, status: :unprocessable_entity }
      end
    end
  end

end
