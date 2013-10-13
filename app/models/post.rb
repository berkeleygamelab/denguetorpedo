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
  attr_accessible :content, :title, :user_id, :parent_id
  acts_as_nested_set

  # associations
  belongs_to :user
  has_one :feed, :as => :target
  belongs_to :wall, :polymorphic => true

  # validations
  validates :title, presence: true
  validates :user_id, :presence => true
  validates :content, :presence => true, :length => {:minimum => 1, :maximum => 350}

  after_create :give_points
  after_destroy :remove_points
  after_create do |post|
    Feed.create_from_object(post, post.user_id, :post)
  end
  
  def strf_updated_at
    self.updated_at.strftime("%d/%m/%Y")
  end
  
  def strf_created_at
    self.created_at.strftime("%d/%m/%Y")
  end

  def give_points
    self.user.update_attribute(:points, self.user.points + 5)
    self.user.update_attribute(:total_points, self.user.total_points + 5)
  end

  def remove_points
    self.user.update_attribute(:points, self.user.points - 5)
    self.user.update_attribute(:total_points, self.user.total_points - 5)
  end
end
