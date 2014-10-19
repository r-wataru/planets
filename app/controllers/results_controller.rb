class ResultsController < ApplicationController
  def index
    @season = Season.last
    @regulation_number = @season.games.count * 1.4
    @display = ResultDisplay.new(@season).display
  end
end