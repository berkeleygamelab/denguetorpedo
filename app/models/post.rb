# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string(255)
#  content    :text
#  type_cd    :integer
#  parent_id  :integer
#  lft        :integer
#  rgt        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  wall_id    :integer
#  wall_type  :string(255)
#

class Post < ActiveRecord::Base
  attr_accessible :content, :title
  acts_as_nested_set

  # associations
  belongs_to :user
  has_one :feed, :as => :target
  belongs_to :wall, :polymorphic => true

  # validations
  validates :user_id, :presence => true
  validates :content, :presence => true

  after_create do |post|
    Feed.create_from_object(post, post.user_id, :post)
  end
end
