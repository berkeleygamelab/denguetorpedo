class Recruitment < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :recruiter, :recruitee, :recruiter_id, :recruitee_id

  belongs_to :recruiter, :class_name => "User"
  belongs_to :recruitee, :class_name => "User"

  validates :recruiter_id, :uniqueness => { :scope => :recruitee_id }
end
