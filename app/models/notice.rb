class Notice < ActiveRecord::Base
  attr_accessible :date, :description, :location, :title, :summary
end
