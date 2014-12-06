class EmailsController < ApplicationController
  def destroy
    @email = current_user.emails.find(params[:id])
    @email.destroy
    redirect_to current_user
  end

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

  def main
    @email = current_user.emails.find(params[:id])
    @email.all_update_main
    redirect_to current_user
  end

  def add
    if params[:token].present?
      @new_email = NewEmail.not_userd.find_by(value: params[:token])
      if current_user
        if current_user == @new_email.user
          current_user.emails.create(address: @new_email.address)
        end
      else
        Email.create(address: @new_email.address, user_id: @new_email.user_id)
        session[:current_user_id] = @new_email.user_id
      end
      redirect_to @new_email.user
    else
      raise
    end
  end
end