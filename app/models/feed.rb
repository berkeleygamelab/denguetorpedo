# == Schema Information
#
# Table name: feeds
#
#  id           :integer          not null, primary key
#  target_type  :string(255)
#  target_id    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#  feed_type_cd :integer
#

class Feed < ActiveRecord::Base
  attr_accessible :feed_type, :target_id, :target_type, :user_id
  belongs_to :target, :polymorphic => true
  belongs_to :user

  validates :target_id, :uniqueness => { :scope => :feed_type_cd }

  as_enum :feed_type, [:reported, :claimed, :eliminated, :post]
  
  def self.create_from_object(target, user_id, type)
    feed = Feed.new(:user_id => user_id, :feed_type => type)
    feed.target = target
    feed.save! ? feed : false
  end
end
