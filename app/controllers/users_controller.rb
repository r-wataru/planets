class UsersController < ApplicationController
  def index
    @users = User.member.order("number ASC")
  end

  def show
    @user = User.member.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
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
    @user = User.find(params[:id])
    @user_form = UserForm.new(@user)
  end

  def update_image
    @user = User.find(params[:id])
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
end