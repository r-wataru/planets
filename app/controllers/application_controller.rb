class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :authenticate_user

  class Forbidden < StandardError; end
  class NotFound < StandardError; end
  class BadRequest < StandardError; end

  private
  # ログインしていないユーザー
  def authenticate_user
    raise Forbidden unless current_user
  end

  rescue_from BadRequest, with: :rescue_400
  rescue_from Forbidden, with: :rescue_403
  rescue_from NotFound, with: :rescue_404

  rescue_from StandardError, with: :rescue_500 unless Rails.env.test? || Rails.env.development?

  if Rails.env.production?
    rescue_from ActionController::RoutingError, with: :rescue_404
    rescue_from ActiveRecord::RecordNotFound, with: :rescue_404
  end

  def current_user
    if session[:current_user_id]
      @current_user ||= User.find_by_id(session[:current_user_id])
    end
    @current_user
  end
  helper_method :current_user

  def current_admin
    current_user && current_user.admin?
  end
  helper_method :current_admin

  def rescue_400(exception)
    @exception = exception
    render "errors/bad_request", status: 400
  end

  def rescue_403(exception)
    @exception = exception
    if request.xhr?
      render "errors/forbidden", status: 403
    elsif request.get? && !current_user
      @form = LoginForm.new
      @from = request.url
      render template: 'errors/login_required',
        layout: "session_form"
    else
      render "errors/forbidden", status: 403
    end
  end

  def rescue_404(exception)
    @exception = exception
    render "errors/not_found", status: 404
  end

  def rescue_500(exception)
    @exception = exception
    render template: "errors/internal_server_error", status: 500
    AccountMailer.internal_server_error(@exception, request, current_user).deliver
  end
end
