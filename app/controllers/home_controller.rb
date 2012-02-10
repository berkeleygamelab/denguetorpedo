class HomeController < ApplicationController
  def index
    # NEIGHBORHOOD MODEL HAS NOT BEEN IMPLEMENTED AND INTEGRATED WITH THE APP YET!!!!

    neighborhoods = Location.top_neighborhoods(5)
    houses_list = House.all_in_neighborhoods(neighborhoods)
    #@houses_maps = @houses_list.collect do |houses| 
    #  houses.collect{ |h| h.location }.to_gmaps4rails
    #end
  end  
end


