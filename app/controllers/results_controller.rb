class ResultsController < ApplicationController
  skip_before_filter :authenticate_user, only: [ :index ]

  def index
    @seasons = Season.all
    @season = params[:season].present? ? Season.find(params[:season]) : Season.last
    @display = ResultDisplay.new(@season, params[:change]).display
    @pitchers = PitcherDisplay.new(@season, params[:p_change]).display
  end

  def new
    @game = Game.find(params[:game_id])
    @pitchers = @game.pitchers
    @results = @game.results
    @season = @game.season
    @new_result = @game.results.new
    @new_pitcher = @game.pitchers.new
  end

  def create
    @game = Game.find(params[:game_id])
    @season = @game.season
    @results = @game.results
    @pitchers = @game.pitchers
    @new_pitcher = @game.pitchers.new
    @new_result = @game.results.new results_params
    if @new_result.save
      flash.notice = "作成しました。"
      redirect_to [ :new, @game, :result ]
    else
      flash.now.alert = "入力に誤りがあります。"
      render action: :new
    end
  end

  def edit
    @game = Game.find(params[:game_id])
    @result = @game.results.find(params[:id])
    @results = @game.results
    @pitchers = @game.pitchers
    @new_result = @game.results.new
    @new_pitcher = @game.pitchers.new
  end

  def update
    @game = Game.find(params[:game_id])
    @result = @game.results.find(params[:id])
    @results = @game.results
    @pitchers = @game.pitchers
    @new_result = @game.results.new
    @new_pitcher = @game.pitchers.new
    if @result.update_attributes results_params
      flash.notice = "更新しました。"
      redirect_to @game
    else
      flash.now.alert = "入力に誤りがあります。"
      render action: :edit
    end
  end

  def destroy
    @game = Game.find(params[:game_id])
    @result = @game.results.find(params[:id])
    @result.destroy
    flash.notice = "削除しました。"
    redirect_to @game
  end

  private
  def results_params
    params.require(:result).permit(
      :user_id,
      :plate_appearances,
      :at_bats,
      :single_hits,
      :double_hits,
      :triple_hits,
      :home_run,
      :base_on_balls,
      :hit_by_pitches,
      :sacrifice_bunts,
      :sacrifice_flies,
      :gaffe,
      :infield_grounder,
      :outfield_grounder,
      :infield_fly,
      :outfield_fly,
      :infield_linera,
      :out_linera,
      :strikeouts,
      :runs_batted_in,
      :runs_scored,
      :stolen_bases,
      :helper_member
    )
  end
end