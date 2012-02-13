class HomeController < ApplicationController
  def index
    @all_neighborhoods = ["All Neighborhoods"] + Location.top_neighborhoods

    if params[:neighborhood].nil? or params[:neighborhood] == "All Neighborhoods"
      @selected_neighborhood = 'All Neighborhood'
      @houses = House.all
    else
      @selected_neighborhood = params[:neighborhood]
      @houses = House.all_in_neighborhoods(@selected_neighborhood)
    end

    @houses_gmap_json = @houses.map {|house| house.location}.to_gmaps4rails

  end
  
end

