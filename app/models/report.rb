class Report < ActiveRecord::Base
  belongs_to :user
  
  def strftime_updated_at
    self.updated_at.strftime("Reported on %m/%d/%Y")
  end
  
  def complete_address
    self.address + ", " + self.neighborhood + ", " + self.city + ", " + self.state + ", " + self.nation
  end
end
