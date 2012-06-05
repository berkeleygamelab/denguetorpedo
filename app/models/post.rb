class Post < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content, :lft, :parent_id, :rgt, :title, :type_cd
end
