class PitchersController < ApplicationController
  def new
    @game = Game.find(params[:game_id])
    @pitcher = @game.pitchers.new
    @users = User.all
  end

  def create
    @game = Game.find(params[:game_id])
    @pitcher = @game.pitchers.new pitcher_params
    if @pitcher.save
      redirect_to [ :new, @game, :result ]
    else
      render action: :new
    end
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
      :save_number
    )
  end
end