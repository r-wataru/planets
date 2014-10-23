class GamesController < ApplicationController
  def new
    @game = Game.new
    @pitcher = Pitcher.new
    @result = Result.new
  end

  def create
    @game = Game.new game_params
    @game.creating_game = true
    if @game.save
      redirect_to [ :new, @game, :pitcher ]
    else
      render action: :new
    end
  end

  def edit
    @game = Game.find(params[:id])
    @pitchers = @game.pitchers
    @results = @game.results
  end

  private
  def game_params
    params.require(:game).permit(
      :season_id,
      :name,
      :played_at,
      :total_result,
      :description,
      :winning,
      :top,
      :one,
      :two,
      :three,
      :four,
      :five,
      :six,
      :seven,
      :eight,
      :nine,
      :total,
      :bottom,
      :one_2,
      :two_2,
      :three_2,
      :four_2,
      :five_2,
      :six_2,
      :seven_2,
      :eight_2,
      :nine_2,
      :total_2)
  end
end