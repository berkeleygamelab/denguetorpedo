# encoding: utf-8
class HousesController < ApplicationController
  before_filter :require_login
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
    @neigh = Neighborhood.first
    # @neighbors = House.joins(:location).joins(:user).where(:locations => {:neighborhood_id => @house.neighborhood.id}, :users => {:role}).limit(5)
    
    excluded_roles = ["lojista", "verificador"]
    @mare = Neighborhood.find_by_name('Maré')
    @neighbors = House.joins(:location).joins(:user).where(:locations => { :neighborhood_id => @neigh.id}).where('users.role NOT IN (?) AND houses.id != ?', excluded_roles, @house.id).uniq.shuffle[0..6]
    @highlightHouseItem = ""
    
    @marker = [{"lat" => @house.location.latitude, "lng" => @house.location.longitude}].to_json
    @markers = @house.reports.map { |report| {x: report.location.latitude, y: report.location.longitude, id: report.location.id}}
    @open_markers = @house.created_reports.map { |report| {x: report.location.latitude, y: report.location.longitude, id: report.location.id}}
    @eliminated_markers = @house.eliminated_reports.map { |report| {x: report.location.latitude, y: report.location.longitude, id: report.location.id}}

    # @counts = @house.reports.group(:location_id).count
    # @open_counts = @house.created_report.group(:location_id).count
    # @eliminated_reports = @house.eliminated_reports.group(:location_id).count

    @counts = @house.report_counts
    @open_counts = @house.open_report_counts
    @eliminated_counts = @house.eliminated_report_counts
    
    if (@current_user != nil && @current_user.house_id == @house.id)
      @highlightHouseItem = "nav_highlight"
    end 
  
  end
end
