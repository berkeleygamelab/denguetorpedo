class Location < ActiveRecord::Base
  acts_as_gmappable

  validates :latitude, :uniqueness => { :scope => :longitude }

  has_one :house

  def points
    house.nil? ? 0 : house.points
  end

  def self.top_neighborhoods(n = 0)
    neighborhood_points = Location.joins(:house => :members).group(:neighborhood).count("users.points")
    sorted_neighborhoods = neighborhood_points.to_a.sort {|i, j| j[1] <=> i[1]}.map {|x| x[0]} 
    n ? sorted_neighborhoods : sorted_neighborhoods[0, n]
  end

  def complete_address
    "#{self.address} #{self.city}, #{self.state}, #{self.nation}"
  end

  def gmaps4rails_address
    complete_address()
  end

  def self.find_or_create(attrs)
    location = Location.new(:nation => attrs[:nation],
                            :state => attrs[:state],
                            :city => attrs[:city],
                            :neighborhood => attrs[:neighborhood],
                            :address => attrs[:address])
    geocode = Gmaps4rails.geocode(location.complete_address())
    if geocode.size != 1
      return render :nothing => true # TODO: give a helpful message if geocoding failed
    end
    lat = geocode[0][:lat]
    lon = geocode[0][:lng]
    
    existing_location = Location.find_by_latitude_and_longitude(lat, lon)
    if existing_location.nil?
      unless location.save
        return render :nothing => true # TODO: do something more appropriate than render nothing
      end
      location
    else
      existing_location
    end
  end

end
