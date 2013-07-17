class HousesController < ApplicationController
  
  def show
    @house = House.includes(:members, :posts, :location => :neighborhood).find(params[:id])
    @user = @house.members[0]
    head :not_found and return if @house.nil?
    
    @house_reports_gmap_json = @house.reports.map {|report| report.location}.to_gmaps4rails
    
    @map_options =  {"center_latitude" => @house.location.latitude, 
                       "center_longitude" => @house.location.longitude,
                       "detect_location" => false,
                       "center_on_user" => false,
                       "auto_adjust" => false,
                       "auto_zoom" => true,
                       "zoom" => 14,
                       "id" => "reports_map"
                 }
                 
    @post = Post.new

    @neighbors = House.joins(:location).where(:locations => {:neighborhood_id => @house.neighborhood.id}).limit(5)
    
    @highlightHouseItem = ""
    
    if (@current_user != nil && @current_user.house_id == @house.id)
      @highlightHouseItem = "nav_highlight"
    end 
  
  end
end
