require 'location.rb'

class Neighborhood
  
  def all_neighborhoods
    Location.all.collect {|loc| loc.neighborhood }.uniq
  end

end