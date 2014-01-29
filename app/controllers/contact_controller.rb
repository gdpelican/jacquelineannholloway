class ContactController < ApplicationController

  def create
    @message = ContactForm.new params[:contact_form].merge({ request: request })
    
    if @message.valid?
      @message.deliver
      redirect_to(root_path, :notice => "Message was successfully sent.")
    else
      flash.now.alert = "Please fill in all fields"
      return
    end
  end

end