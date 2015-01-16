class SessionsController < ApplicationController
  layout "session_form"

  skip_before_filter :authenticate_user

  def new
    if current_user
      redirect_to :root
    else
      @form = LoginForm.new
    end
  end

  def create
    @form = LoginForm.new(params[:login_form])
    if @form.email.present?
      email = Email.find_by(address: @form.email)
      if email.nil?
        user = User.find_by(login_name: @form.email)
        email = user.emails.find_by(main: true) if user
      end
    end
    if Authenticator.new(email).authenticate(@form.password)
      session[:current_user_id] = email.user.id
      email.user.update_attribute(:logged_at, Time.current)
      if params[:from]
        flash.notice = "ログインしました。"
        redirect_to params[:from]
      else
        flash.notice = "ログインしました。"
        redirect_to :root
      end
    else
      flash.now.alert = "入力内容が正しくありません。"
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
        if current_user
          @user.user = current_user
          if @user.save
            render :callback
          else
            render "failure"
          end
        else
          render :callback
        end
      else
        if current_user
          redirect_to :back
        else
          session[:current_user_id] = user_identity.user.id
          render :callback
        end
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