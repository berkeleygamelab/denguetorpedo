class VerificationsController < ApplicationController

  before_filter :require_login
  before_filter :check_is_verifier

  private
  def check_is_verifier
    head :forbidden and return unless @current_user.is_verifier
  end

  public
  def index
  end

end
