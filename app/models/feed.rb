class Feed < ActiveRecord::Base
  attr_accessible :feed_type, :target_id, :target_type
  belongs_to :target, :polymorphic => true
  belongs_to :user
  
  def self.create_from_object(object, user_id, type)
    feed = Feed.new(:target => object, :user_id => user_id, :feed_type => type)
    return feed.save ? feed : false
  end
end
