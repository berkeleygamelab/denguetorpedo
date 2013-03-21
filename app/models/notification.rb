class Notification < ActiveRecord::Base
  attr_accessible :board, :phone, :text
end
