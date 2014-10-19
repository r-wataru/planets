class ResultsController < ApplicationController
  def index
    @season = Season.last
    @display = ResultDisplay.new(@season, params[:change]).display
    @pitchers = PitcherDisplay.new(@season, params[:p_change]).display
  end
end