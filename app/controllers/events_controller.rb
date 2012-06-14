class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    @comment = EventComment.new
    @comment.event_id = @event.id

    respond_to do |format|
      format.js
    end
  end
end
