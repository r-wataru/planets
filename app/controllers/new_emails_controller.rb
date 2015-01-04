class NewEmailsController < ApplicationController
  def new
    @email = NewEmail.new
    unless current_user
      render "new", layout: "session_form"
    end
  end

  def create
    if current_user && params[:new_email][:user_id].present?
      @email = NewEmail.new email_params
    else
      @email = NewEmail.new params.require(:new_email).permit(:address)
    end
    if @email.save
      @email.delivery_token
      redirect_to :thanks_new_email
    else
      render action: :new
    end
  end

  def thanks
    unless current_user
      render "thanks", layout: "session_form"
    end
  end

  private
  def email_params
    params.require(:new_email).permit(:address, :user_id)
  end
end