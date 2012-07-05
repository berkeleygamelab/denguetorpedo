require 'active_support/core_ext'

class Location < ActiveRecord::Base
  attr_accessible
  acts_as_gmappable :callback => :geocode_results, :validation => true
  validates :latitude, :uniqueness => { :scope => :longitude }
  validates :neighborhood_id, :presence => true

  has_one :house
  belongs_to :neighborhood
  has_many :reports

  def neighborhood_name
    self.neighborhood && self.neighborhood.name
  end

  def geocode_results(data)
    # reset all these fields so we can extract it from the geocoding data
    self.nation = nil
    self.state = nil
    self.city = nil
    self.address = nil

    components = {}
    for c in data["address_components"]
      for t in c["types"]
        components[t] = c["long_name"]
      end
    end

    self.nation = components["country"]
    self.state = components["administrative_area_level_1"]
    self.city = components["locality"] || components["administrative_level_3"] || components["administrative_level_2"]
    self.neighborhood = Neighborhood.find_or_create_by_name(components["neighborhood"] || self.neighborhood_name || self.city)
    self.address = "#{components['street_number']} #{components['route']}"
    self.formatted_address = data["formatted_address"]
  end

  def points
    house.nil? ? 0 : house.points
  end

  def complete_address
    self.gmaps4rails_address
  end

  def gmaps4rails_address
    self.formatted_address || self.address
  end

  def self.find_or_create(address)
    # construct the Location object using the argument
    if address.class == String
      location = Location.new
      location.address = address
    elsif address.class <= Hash
      puts 'hash!@#@!#'
      location = Location.new(address) # TODO: fix security issue...
    else
      return nil
    end

    # if the id argument is also passed, return the existing object that matches the id
    if location.id != nil
      existing_location = Location.find(location.id)
      return existing_location unless existing_location.nil?
    end

    # do the geocoding
    puts "location is %s", address
    geocode = Gmaps4rails.geocode(location.complete_address())
    if geocode.size != 1
      return nil
    end
    lat = geocode[0][:lat]
    lon = geocode[0][:lng]
    
    # find if any existing objects match the lat and lon
    existing_location = Location.find_by_latitude_and_longitude(lat, lon)
    if existing_location.nil?
      # no objects match the same location, so save the location object
      location.latitude = lat
      location.longitude = lon
      unless location.save
        return nil
      end
      location
    else
      # return the existing object that matches the same lat and lon
      existing_location
    end
  end

end

