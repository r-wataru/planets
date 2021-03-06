class GamesController < ApplicationController
  skip_before_filter :authenticate_user, only: [ :show ]

  def show
    @game = Game.find(params[:id])
    @pitchers = @game.pitchers
    @results = @game.results
    @new_result = @game.results.new
    @new_pitcher = @game.pitchers.new
    @season = @game.season
  end

  def new
    @game = Game.new
    @pitcher = Pitcher.new
    @result = Result.new
  end

  def create
    @game = Game.new game_params
    @game.creating_game = true
    if @game.save
      flash.notice = "作成しました。"
      redirect_to [ :new, @game, :pitcher ]
    else
      flash.now.alert = "入力に誤りがあります。"
      render action: :new
    end
  end

  def edit
    @game = Game.find(params[:id])
    @pitchers = @game.pitchers
    @results = @game.results
    @new_pitcher = @game.pitchers.new
    @new_result = @game.results.new
    @season = @game.season
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes game_params
      flash.notice = "更新しました。"
      redirect_to @game
    else
      flash.now.alert = "入力に誤りがあります。"
      render action: :new
    end
  end

  def update_reflection
    @game = Game.find(params[:id])
    @game.update_reflection
    flash.notice = "更新しました。"
    redirect_to :results
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