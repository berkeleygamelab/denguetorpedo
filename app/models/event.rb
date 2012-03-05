class Event < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  has_many :comments, :class_name => "EventComment"
end
