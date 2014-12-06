class EmailsController < ApplicationController
  def forgot_password
    @form = ForgotForm.new
  end

  def forgot_send_mail
    @form = ForgotForm.new(params[:forgot_form])
    if @form.send_token
      redirect_to :thanks_emails
    else
      render action: :forgot_password
    end
  end

  def thanks
  end
end