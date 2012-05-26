class EventComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :content, :presence => true
  validates :user_id, :presence => true
  validates :event_id, :presence => true

  after_create do |event_comment|
    Feed.create_from_object(event_comment, event_comment.user_id, "event_comment")
  end
end
