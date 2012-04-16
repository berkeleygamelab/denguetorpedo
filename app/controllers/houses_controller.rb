class HousesController < ApplicationController
  
  def index
  end
  
  def show
    @house = House.includes(:members, :events,
                            :location => :neighborhood, :comments => :user).find(params[:id])
    head :not_found and return if @house.nil?

    @house_reports_gmap_json = @house.reports.map {|report| report.location}.to_gmaps4rails

    if @house.events.exists?
      @event = @house.events[0]
      @comment = EventComment.new
      @comment.event_id = @house.events[0].id
    end

    @neighbors = House.joins(:location).where(:locations => {:neighborhood_id => @house.neighborhood.id})
  end
end
