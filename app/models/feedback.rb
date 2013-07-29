class Feedback < ActiveRecord::Base
  attr_accessible :email, :message, :name, :title
end
