class EmailsController < ApplicationController
  skip_before_filter :authenticate_user, except: [ :destroy, :main ]

  def destroy
    @email = current_user.emails.find(params[:id])
    @email.destroy
    redirect_to current_user
  end

  def forgot_password
    @form = ForgotForm.new
    render "forgot_password", layout: "session_form"
  end

  def forgot_send_mail
    @form = ForgotForm.new(params[:forgot_form])
    if @form.send_token
      redirect_to :thanks_emails
    else
      render "forgot_password", layout: "session_form"
    end
  end

  def thanks
    render "thanks", layout: "session_form"
  end

  def main
    @email = current_user.emails.find(params[:id])
    @email.all_update_main
    redirect_to current_user
  end

  def failure
  end

  def add
    if params[:token].present?
      if @new_email = NewEmail.not_userd.find_by(value: params[:token])
        if Time.current < (@new_email.created_at + 1.hour)
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
          render :failure, layout: "session_form"
        end
      else
        raise
      end
    else
      raise
    end
  end
end