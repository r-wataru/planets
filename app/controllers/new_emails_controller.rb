class NewEmailsController < ApplicationController
  def new
    @email = NewEmail.new
  end

  def create
    @email = NewEmail.new params.require(:new_email).permit(:address)
    if @email.save
      @email.delivery_token
      redirect_to :thanks_new_email
    else
      render action: :new
    end
  end

  def thanks
  end
end