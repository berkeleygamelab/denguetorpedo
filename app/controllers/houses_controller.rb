# encoding: utf-8
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
    @mare = Neighborhood.find_by_name('Maré')
    @neighbors = House.joins(:location).joins(:user).where(:locations => { :neighborhood_id => 1}).where('users.role NOT IN (?) AND houses.id != ?', excluded_roles, 1).uniq.shuffle[0..6]
    @highlightHouseItem = ""
    
    @marker = [{"lat" => @house.location.latitude, "lng" => @house.location.longitude}].to_json
    if (@current_user != nil && @current_user.house_id == @house.id)
      @highlightHouseItem = "nav_highlight"
    end 
  
  end
end
