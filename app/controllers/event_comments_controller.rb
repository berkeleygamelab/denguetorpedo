class EventCommentsController < ApplicationController
  
  def create
    EventComment.create(params[:event_comment])
    redirect_to :back
  end

end
