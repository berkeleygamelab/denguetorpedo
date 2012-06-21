class Feed < ActiveRecord::Base
  # associations
  belongs_to :target, :polymorphic => true
  belongs_to :user

  # validations
  validates :target_id, :uniqueness => { :scope => :feed_type_cd }

  as_enum :feed_type, [:reported, :claimed, :eliminated, :post]

  def self.create_from_object(target, user_id, type)
    feed = Feed.create do |feed|
      feed.user_id = user_id
      feed.target = target
      feed.feed_type = type
    end

    return feed
  end
end
