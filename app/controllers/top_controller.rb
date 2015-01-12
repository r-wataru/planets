class TopController < ApplicationController
  skip_before_filter :authenticate_user

  def index
    @game = Game.last
    @still = PlanDetail.includes(:plan).
      where("plans.starts_on >= ?", Date.today ).
      order('plans.starts_on ASC').limit(4)
    @news = New.order("id DESC").limit(8)
    render :index, layout: "application"
  end

  def internal_server_error
    raise StandardError
  end
end