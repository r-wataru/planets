class PitchersController < ApplicationController
  def new
    @game = Game.find(params[:game_id])
    @pitchers = @game.pitchers
    @new_pitcher = @game.pitchers.new
    @new_result = @game.results.new
  end

  def create
    @game = Game.find(params[:game_id])
    @new_pitcher = @game.pitchers.new pitcher_params
    @new_result = @game.results.new
    @pitchers = @game.pitchers
    @results = @game.results
    if @new_pitcher.save
      flash.notice = "更新しました。"
      redirect_to [ :new, @game, :result ]
    else
      flash.now.alert = "入力に誤りがあります。"
      render action: :new
    end
  end

  def edit
    @game = Game.find(params[:game_id])
    @pitcher = @game.pitchers.find(params[:id])
    @pitchers = @game.pitchers
    @results = @game.results
    @new_pitcher = @game.pitchers.new
    @new_result = @game.results.new
  end

  def update
    @game = Game.find(params[:game_id])
    @pitcher = @game.pitchers.find(params[:id])
    @pitchers = @game.pitchers
    @results = @game.results
    @new_pitcher = @game.pitchers.new
    @new_result = @game.results.new
    if @pitcher.update_attributes pitcher_params
      flash.notice = "更新しました。"
      redirect_to @game
    else
      flash.now.alert = "入力に誤りがあります。"
      render action: :edit
    end
  end

  def destroy
    @game = Game.find(params[:game_id])
    @pitcher = @game.pitchers.find(params[:id])
    @pitcher.destroy
    flash.notice = "削除しました。"
    redirect_to @game
  end

  def pitcher_params
    params.require(:pitcher).permit(
      :user_id,
      :pitching_number,
      :hit,
      :run,
      :remorse_point,
      :strikeouts,
      :winning,
      :defeat,
      :hold_number,
      :save_number,
      :helper_member,
      :helper_member
    )
  end
end