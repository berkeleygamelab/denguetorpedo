class HomeController < ApplicationController
  def index
    # NEIGHBORHOOD MODEL HAS NOT BEEN IMPLEMENTED AND INTEGRATED WITH THE APP YET!!!!
    
    @neighborhoods = Neighborhood.top_five
    @houses_list = @neighborhoods.collect { |n| n.houses }
    @houses_maps = @houses_list.collect do |houses| 
      houses.collect{ |h| h.location }.to_gmaps4rails
    end
  end

end


