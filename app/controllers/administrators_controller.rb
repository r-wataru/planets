class AdministratorsController < ApplicationController
  before_filter :authenticate_admin

  def index
    @users = User.all.order("id ASC")
  end

  def create
    user = User.find(params[:user_id])
    session.delete(:current_user_id)
    session[:current_user_id] = user.id
    flash.notice = "代理ログインしました。"
    redirect_to :root
  end

  private
  def authenticate_admin
    raise NotFound unless current_admin
  end
end