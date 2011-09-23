class Report < ActiveRecord::Base
  acts_as_gmappable
  
  belongs_to :user
  
  def strftime_updated_at
    self.updated_at.strftime("Reported on %m/%d/%Y")
  end
  
  def complete_address
    ret = self.address
    ret += ", " + self.neighborhood unless self.neighborhood.nil?
    ret += "#{self.city}, #{self.state}, #{self.nation}"
    ret
  end
  def gmaps4rails_address
    complete_address()
  end
end
