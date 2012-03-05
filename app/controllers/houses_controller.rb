class HousesController < ApplicationController
  
  def index
  end
  
  def show
    @house = House.includes(:members, :location, 
                            :events, :comments => :user,
                            :created_reports => :location, 
                            :claimed_reports => :location, 
                            :eliminated_reports => :location).find(params[:id])
    head :not_found and return if @house.nil?

    @house_reports_gmap_json = @house.reports.map {|report| report.location}.to_gmaps4rails
    #@isPrivatePage = (@current_user != nil and @current_user.house == @house)
    @event = @house.events[0]

    @comment = EventComment.new
    @comment.event_id = @house.events[0].id
  end
end
