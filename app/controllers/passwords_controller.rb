class PasswordsController < ApplicationController
  layout "session_form"

  def new
    if params[:token].present?
      if @user_token = UserToken.active.find_by(value: params[:token])
        @change_password_form = ChangePasswordForm.new(object: @user_token.user)
      else
        raise
      end
    else
      raise
    end
  end

  def create
    @change_password_form = ChangePasswordForm.new(password_params)
    @user_token = UserToken.find_by(value: @change_password_form.token)
    @change_password_form.not_current_user = true
    @change_password_form.object = @user_token.user
    if @change_password_form.save
      @user_token.update_column(:used, true)
      session[:current_user_id] = @user_token.user.id
      redirect_to @user_token.user
    else
      unless current_user
        render action: :new
      end
    end
  end

  private
  def password_params
    params.require(:change_password_form).permit(
      :new_password, :new_password_confirmation, :token)
  end
end