class TopController < ApplicationController
  skip_before_filter :authenticate_user

  def index
    render :index, layout: "application"
  end

  def internal_server_error
    raise StandardError
  end
end