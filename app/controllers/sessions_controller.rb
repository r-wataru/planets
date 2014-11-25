class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to :root
    else
      @form = LoginForm.new
      render action: 'new'
    end
  end
  
  def create
    @form = LoginForm.new(params[:login_form])
    if @form.email.present?
      email = Email.find_by(address: @form.email)
    end
    if Authenticator.new(email).authenticate(@form.password)
      session[:current_user_id] = email.user.id
      email.user.update_attribute(:logged_at, Time.current)
      redirect_to :root
    else
      render action: :new
    end
  end
  
  def destroy
    session.delete(:current_user_id)
    redirect_to :new_session
  end
end