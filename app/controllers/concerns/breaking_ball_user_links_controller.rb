class BreakingBallUserLinksController < ApplicationController
  def update
    @user = User.find(params[:user_id])
    @link = @user.breaking_ball_user_links.find(params[:id])
    p @link.level
    breaking_ball_id = params[:ball][:select_value]
    level = params[:ball][:select_level]
    @link.breaking_ball_id = breaking_ball_id.to_i
    @link.level = level.to_i
    if @link.save
      render text: "OK"
    else
      render text: "NG"
    end
  end

  def create
    @user = User.find(params[:user_id])
    breaking_ball_id = params[:ball][:select_value]
    level = params[:ball][:select_level]
    @ball = @user.breaking_ball_user_links.new(
      breaking_ball_id: breaking_ball_id,
      level: level)
    if @ball.save
      render text: "OK"
    else
      render text: "NG"
    end
  end
end