class Location < ActiveRecord::Base
  acts_as_gmappable

  validates :latitude, :uniqueness => { :scope => :longitude }

  has_one :house

  def points
    if house.nil?
      0
    else
      house.points
    end
  end

  def self.top_neighborhoods(n)
    neighborhood_points = Location.joins(:house => :members).group(:neighborhood).count("users.points")
    sorted_neighborhoods = neighborhood_points.to_a.sort do |i, j| j[1] <=> i[1] end.map do |x| x[0] end
    sorted_neighborhoods[0, n]
  end

  def complete_address
    "#{self.address} #{self.city}, #{self.state}, #{self.nation}"
  end

  def gmaps4rails_address
    complete_address()
  end

end
