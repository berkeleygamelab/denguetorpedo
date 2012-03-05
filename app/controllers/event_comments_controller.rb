class EventCommentsController < ApplicationController

  def show

  end
  
  def create
    unless @user.nil?
      params[:event_comment][:user_id] = @user.id
    end
    EventComment.create(params[:event_comment])
    redirect_to :back
  end

end
