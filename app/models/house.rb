class House < ActiveRecord::Base
  has_many :members, :class_name => "User"
  has_many :events, :through => :members
end
