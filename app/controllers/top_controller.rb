class TopController < ApplicationController
  def index
    if current_user
      render :index, layout: "application"
    else
      render :index, layout: "before_authentication"
    end
  end
end