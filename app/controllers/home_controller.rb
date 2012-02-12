class HomeController < ApplicationController
  
  def index
    @all_neighborhoods = ["All Neighborhoods"] + Location.top_neighborhoods
    params[:neighborhood].nil? ? (@selected_neighborhood = 'All Neighborhoods') : (@selected_neighborhood =  params[:neighborhood])
    (@selected_neighborhood == 'All Neighborhoods') ? (@houses = House.all) : (@houses = House.all_in_neighborhoods(@selected_neighborhood))
    @houses_gmap_json = @houses.collect {|house| house.location.to_gmaps4rails}
  end
  
end

