class HousesController < ApplicationController
  
  def index
  end
  
  def show
    @house = House.find_by_id(params[:id])
    @house_reports_gmap_json = @house.reports.map {|report| report.location}.to_gmaps4rails
    #head :not_found and return if @house.nil?
    #@isPrivatePage = (@current_user != nil and @current_user.house == @house)
    #@comment = EventComment.new
  end
end
