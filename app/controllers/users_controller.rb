class UsersController < ApplicationController
  def index
    @users = User.member.order("number ASC")
  end
  
  def show
    @user = User.member.find(params[:id])
  end
end