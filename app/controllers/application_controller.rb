# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :current_user

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "public/401.html", :status => :unauthorized
  end
  
  private
  
  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]  
  end

  protected
  
  def require_login
    flash[:alert] = "Faça o seu login para visualizar essa página." if @current_user.nil?
    redirect_to root_url if @current_user.nil?
    # head :u and return if @current_user.nil?
  end


end
