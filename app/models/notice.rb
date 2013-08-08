class Notice < ActiveRecord::Base
  attr_accessible :date, :description, :location, :title, :summary, :photo

  has_attached_file :photo, :styles => {:small => "60x60>", :medium => "150x150>" , :large => "225x225>"}

  def hour
  end
end
