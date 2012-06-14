class Feed < ActiveRecord::Base
  attr_accessible :feed_type, :target_id, :target_type, :user_id
  belongs_to :target, :polymorphic => true
  belongs_to :user

  validates :target_id, :uniqueness => { :scope => :feed_type_cd }

  as_enum :feed_type, [:reported, :claimed, :eliminated, :event, :event_comment]
  
  def self.create_from_object(target, user_id, type)
    feed = Feed.new(:user_id => user_id, :feed_type => type)
    feed.target = target
    feed.save ? feed : false
  end
end
