class UsersController < ApplicationController
  def index
    @users = User.member.order("number ASC")
  end

  def show
    @user = User.member.find(params[:id])
    @characters = @user.characters
    @breaking_ball_links = @user.breaking_ball_user_links
    @results = @user.results.order("id DESC")
    @pitchers = @user.pitchers.order("id DESC")
  end

  def edit
    @user = current_user
    @characters = Character.result
    @picher_characters = Character.pitcher
    @breaking_balls = BreakingBall.all
  end

  def update_ability
    @user = User.find(params[:id])
    field = params[:users][:field]
    value = params[:users][:value]
    if @user.update_ability(field, value)
      render text: "OK"
    else
      render text: "NG"
    end
  end

  def edit_image
    @user = current_user
    @user_form = UserForm.new(@user)
  end

  def update_image
    @user = current_user
    @user_form = UserForm.new(@user)
    @user_form.assign_attributes(params[:user_form])
    if @user_form.save
      flash.notice = 'ユーザー情報を更新しました。'
      redirect_to action: 'index'
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: 'edit_image'
    end
  end

  def thumbnail
    @user = User.find(params[:id])
    if params[:format].in?(["jpg", "png", "gif"])
      send_image
    end
  end

  def cover
    @user = User.find(params[:id])
    if params[:format].in?(["jpg", "png", "gif"])
      send_cover_image
    end
  end

  def new
    if current_user
      raise
    else
      if NewEmail.not_userd.exists?(value: params[:token]) || session[:omniauth_provider].present?
        @users = User.where(checked: false)
        @user = User.new
        render :new, layout: "session_form"
      else
        raise
       end
    end
  end

  def step2
    if request.post?
      if current_user
        redirect_to :root
      else
        if NewEmail.not_userd.exists?(value: params[:user][:token]) || session[:omniauth_provider].present?
          if params[:user][:id] == "0"
            @user = User.new
            @new_user = true
            # Email or Facebook
            @from_email = session[:omniauth_provider].present? ? false : true
          elsif params[:user][:id].blank?
            @users = User.where(checked: false)
            @user = User.new
            render action: :new
          else
            @user = User.find(params[:user][:id])
            # Email or Facebook
            @from_email = session[:omniauth_provider].present? ? false : true
          end
        else
          raise
        end
        render "step2", layout: "session_form"
      end
    else
      raise
    end
  end

  def step3
    if !request.post? || current_user
      raise
    else
      if params[:user][:user_id]
        @user = User.find(params[:user][:user_id])
        @user.assign_attributes user_params
      else
        @user = User.new user_params
      end
      if @user.valid?
        render "step3", layout: "session_form"
      else
        render "step2", layout: "session_form"
      end
      if NewEmail.not_userd.exists?(value: @user.token)
        @from_email = true
      elsif session[:omniauth_provider].blank?
        raise
      end
    end
  end

  def create
    if current_user
      redirect_to :root
    else
      # パスワード確認
      @user = User.new user_params
      if AuthenticateMember.new.authenticate(@user.planets_password)
        @user.checked = true
        if @user.save
          if session[:omniauth_provider].present?
            # Facebook
            facebook_new_user
          else
            # Email
            new_user_from_email
          end
          redirect_to :root
        else
          render action: :step2
        end
      else
        render action: :step3
      end
    end
  end

  def update
    if current_user
      redirect_to :root
    else
      # パスワード確認
      @user = User.find(params[:id])
      @user.assign_attributes user_params
      if AuthenticateMember.new(@user).authenticate(@user.planets_password)
        @user.checked = true
        if @user.save
          # Email
          if session[:omniauth_provider].present?
            facebook_new_user
          else
            new_user_from_email
          end
          redirect_to :root
        else
          render action: :step2
        end
      else
        render action: :step3
      end
    end
  end

  def edit_password
    @change_password_form = ChangePasswordForm.new(object: current_user)
  end

  def update_password
    @change_password_form = ChangePasswordForm.new(password_params)
    @change_password_form.not_current_user = false
    @change_password_form.object = current_user
    if @change_password_form.save
      redirect_to current_user
    else
      render action: :edit_password
    end
  end

  private
  def send_cover_image
    if @user.image.present?
      send_data @user.image.data,
        type: @user.image.content_type, disposition: "inline"
    else
      raise NotFound
    end
  end

  def send_image
    if @user.image.present?
      send_data @user.image.thumbnail,
        type: @user.image.thumbnail_content_type, disposition: "inline"
    else
      raise NotFound
    end
  end

  def user_params
    params.require(:user).permit(
      :number, :login_name, :display_name, :birthday,
      :token, :password, :planets_password)
  end

  def facebook_new_user
    ui = UserIdentity.create!(
      user: @user,
      provider: session[:omniauth_provider],
      uid: session[:omniauth_uid],
      info: session[:omniauth_info]
    )
    ui.user.emails << Email.new(address: session[:omniauth_info], main: true)
    session.delete(:omniauth_provider)
    session.delete(:omniauth_uid)
    session.delete(:omniauth_info)
    session[:current_user_id] = ui.user_id
    ui.user.update_column(:logged_at, Time.current)
  end

  def new_user_from_email
    new_email = NewEmail.find_by(value: @user.token)
    @user.emails.create(address: new_email.address, main: true)
    new_email.update_column(:used, true)
    session[:current_user_id] = @user.id
  end

  def password_params
    params.require(:change_password_form).permit(
      :current_password,
      :new_password, :new_password_confirmation)
  end
end