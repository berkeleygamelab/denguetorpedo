class EventCommentsController < ApplicationController
  before_filter :create, :only => [:create]

  def show

  end
  
  def create
    params[:event_comment][:user_id] = @current_user.id
    EventComment.create(params[:event_comment])
    redirect_to :back
  end
end
