class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :current_user
  
  private
  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]  
  end

  protected
  def require_login
    head :forbidden and return if @current_user.nil?
  end
end
