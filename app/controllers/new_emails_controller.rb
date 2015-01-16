class NewEmailsController < ApplicationController
  skip_before_filter :authenticate_user

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
      flash.notice = "メールを送信しました。"
      redirect_to :thanks_new_email
    else
      flash.now.alert = "入力に誤りがあります。"
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