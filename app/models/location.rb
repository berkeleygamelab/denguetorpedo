# == Schema Information
#
# Table name: locations
#
#  id                :integer          not null, primary key
#  nation            :string(255)
#  state             :string(255)
#  city              :string(255)
#  address           :string(255)
#  latitude          :float
#  longitude         :float
#  gmaps             :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  formatted_address :string(255)
#  neighborhood_id   :integer
#

require 'active_support/core_ext'

class Location < ActiveRecord::Base
  attr_accessible
  # acts_as_gmappable :callback => :geocode_results, :validation => true
  # validates :latitude, :uniqueness => { :scope => :longitude }
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
    self.address = "#{components['street_number']} #{components['route']}"
    self.formatted_address = data["formatted_address"]
  end

  def self.within_bounds(bounds)
      self.where(:location.within => {"$box" => bounds })
  end

  def points
    house.nil? ? 0 : house.points
  end

  def complete_address
    # self.gmaps4rails_address

    return self.street_type + " " + self.street_name + " " + self.street_number + " " + self.neighborhood.name
  end

  def gmaps4rails_address
    self.formatted_address || self.address
  end


  def self.find_or_create(address, neighborhood=nil)
    # construct the Location object using the argument
    if address.class == String
      location = Location.new
      location.address = address
    elsif address.class <= Hash
      location = Location.new(address) # TODO: fix security issue...
    else
      return nil
    end

    # if the id argument is also passed, return the existing object that matches the id
    if location.id != nil
      existing_location = Location.find(location.id)
      return existing_location unless existing_location.nil?
    end

    location.neighborhood = Neighborhood.find_or_create_by_name(neighborhood)
    location.save!
    return location

    # do the geocoding
    # geocoding_success = false
    # geocode = nil
    # 3.times do
    #   begin
    #     geocode = Gmaps4rails.geocode(location.complete_address())
    #   rescue
    #     sleep 3
    #     next
    #   end
    #   geocoding_success = true
    #   break
    # end
    
    # return nil unless geocoding_success and geocode.size > 0
    
    # puts geocode
    
    # lat = geocode[0][:lat]
    # lon = geocode[0][:lng]
    
    # # find if any existing objects match the lat and lon
    # existing_location = Location.find_by_latitude_and_longitude(lat, lon)
    
    # if existing_location.nil?
    #   # no objects match the same location, so save the location object
    #   location.latitude = lat
    #   location.longitude = lon
            
    #   3.times do
    #     if !neighborhood.nil?
    #       location.neighborhood = Neighborhood.find_or_create_by_name(neighborhood)
    #     else
    #       components = {}
    #       for c in geocode[0][:full_data]["address_components"]
    #         for t in c["types"]
    #           components[t] = c["long_name"]
    #         end
    #       end
          
    #       location.neighborhood = Neighborhood.find_or_create_by_name(components["neighborhood"] || location.neighborhood_name || location.city)
          
    #     end
        
    #     return location if location.save
    #     sleep 3
    #   end
      
    #   return nil
    # else
      
    #   # let's say using lat and lon, we found a location. We need to check if the address actually matches with the provided address closely.
    #   # If the two locations are completely different, we should still generate a new address.
      
    #   # return the existing object that matches the same lat and lon
    #   existing_location
    # end
  end

end

