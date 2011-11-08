class EventComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :content, :presence => true
end
