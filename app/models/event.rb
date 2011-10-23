class Event < ActiveRecord::Base
  belongs_to :creator
  has_many :comments, :class_name => "EventComment"
end
