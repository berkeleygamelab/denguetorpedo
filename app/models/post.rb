class Post < ActiveRecord::Base
  attr_accessible :user_id, :content, :lft, :parent_id, :rgt, :title, :type_cd
  acts_as_nested_set

  # associations
  belongs_to :user
  has_one :feed, :as => :target

  # validations
  validates :user_id, :presence => true
  validates :content, :presence => true

  after_create do |post|
    Feed.create_from_object(post, post.user_id, :post)
  end
end
