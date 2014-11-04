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
end