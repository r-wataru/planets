class TopController < ApplicationController
  skip_before_filter :authenticate_user

  def index
    if current_user
      render :index, layout: "application"
    else
      render :index, layout: "session_form"
    end
  end

  def internal_server_error
    raise StandardError
  end
end