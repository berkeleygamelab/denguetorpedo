class HousesController < ApplicationController
  
  def show
    @house = House.includes(:members, :posts, :location => :neighborhood).find(params[:id])
    head :not_found and return if @house.nil?
    head :not_found and return if @house.user.role == "lojista"
    
    # @house_reports_gmap_json = @house.reports.map {|report| report.location}.to_gmaps4rails
    
    # @map_options =  {"center_latitude" => @house.location.latitude, 
                 #       "center_longitude" => @house.location.longitude,
                 #       "detect_location" => false,
                 #       "center_on_user" => false,
                 #       "auto_adjust" => false,
                 #       "auto_zoom" => true,
                 #       "zoom" => 14,
                 #       "id" => "reports_map"
                 # }
                 
    @post = Post.new

    # @neighbors = House.joins(:location).joins(:user).where(:locations => {:neighborhood_id => @house.neighborhood.id}, :users => {:role}).limit(5)
    
    excluded_roles = ["lojista", "verficidador"]
    @neighbors = House.joins(:location).joins(:user).where(:locations => { :neighborhood_id => 2}).where('users.role NOT IN (?)', excluded_roles)[0..7]
    @highlightHouseItem = ""
    
    if (@current_user != nil && @current_user.house_id == @house.id)
      @highlightHouseItem = "nav_highlight"
    end 
  
  end
end
