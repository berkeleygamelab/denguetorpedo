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

end
