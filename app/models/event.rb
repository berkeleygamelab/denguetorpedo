class Event < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  has_many :comments, :class_name => "EventComment"

  validates :creator_id, :presence => true
  validates :description, :presence => true
  validates :category, :presence => true
  validates :praised, :presence => true

  after_initialize :default_values

  private
  def default_values
    self.praised ||= 0
  end
end
