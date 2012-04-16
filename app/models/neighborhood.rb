class Neighborhood < ActiveRecord::Base
  attr_accessible :name

  has_many :locations
  has_many :houses, :through => :locations
  has_many :members, :through => :houses
  has_many :reports, :through => :locations
end
