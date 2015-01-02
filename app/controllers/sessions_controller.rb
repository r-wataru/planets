class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to :root
    else
      @form = LoginForm.new
      render action: 'new', layout: "session_form"
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
      if params[:from]
        redirect_to params[:from]
      else
        redirect_to :root
      end
    else
      render action: :new
    end
  end

  def callback
    if request.env['omniauth.auth']
      user_identity = OmniAuthAuthenticator.verify(env['omniauth.auth'])
      if user_identity.new_record?
        session[:omniauth_provider] = user_identity.provider
        session[:omniauth_uid] = user_identity.uid
        session[:omniauth_info] = user_identity.info
        @user = user_identity
        render :callback
      else
        session[:current_user_id] = user_identity.user.id
        render :callback
      end
    else
      render "failure"
    end
  end

  # GET (for OmniAuth)
  def failure
  end

  def destroy
    session.delete(:current_user_id)
    redirect_to :new_session
  end
end