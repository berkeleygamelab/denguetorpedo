class Location < ActiveRecord::Base
  acts_as_gmappable

  validates :latitude, :uniqueness => { :scope => :longitude }

  def complete_address
    ret = self.address
#    ret += (", " + self.neighborhood + ' ') unless self.neighborhood.nil?
    ret += " #{self.city}, #{self.state}, #{self.nation}"
    ret
  end

  def gmaps4rails_address
    complete_address()
  end

end
