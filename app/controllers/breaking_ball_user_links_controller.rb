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

  def destroy
    @user = User.find(params[:user_id])
    @ball = @user.breaking_ball_user_links.find(params[:id])
    @ball.destroy
    render text: "OK"
  end

  # BreakingBallを作成してLinkを作成
  def create_breaking_ball
    @user = User.find(params[:user_id])
    breaking_ball_id = params[:ball][:select_value]
    level = params[:ball][:select_level]
    value = params[:ball][:value]
    if breaking_ball_id == "0"
      bb = BreakingBall.new(name: value)
      if bb.save
        @ball = @user.breaking_ball_user_links.new(
          breaking_ball_id: bb.id,
          level: level)
        if @ball.save
          render text: "OK"
        else
          render json: {
            errors: true,
            error_keys: @ball.errors.messages.map{|k,v| k},
            error_message: @ball.errors.messages
          }
        end
      else
        render json: {
          errors: true,
          error_message: bb.errors.messages,
          error_keys: bb.errors.messages.map{|k,v| k}
        }
      end
    else
      render text: "NG"
    end
  end
end