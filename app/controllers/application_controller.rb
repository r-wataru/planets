class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  private
  def current_user
    if session[:current_user_id]
      @current_user ||= User.find_by_id(session[:current_user_id])
    end
    @current_user
  end
  helper_method :current_user
end
