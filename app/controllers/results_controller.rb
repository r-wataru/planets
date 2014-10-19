class ResultsController < ApplicationController
  def index
    @season = Season.last
    @display = ResultDisplay.new(@season, params[:change]).display
  end
end