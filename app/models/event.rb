class Event < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  has_many :comments, :class_name => "EventComment"
  has_one :feed, :as => :target

  validates :creator_id, :presence => true
  validates :description, :presence => true
  validates :category, :presence => true
  validates :praised, :presence => true

  as_enum :category, [:story, :prevention_idea, :special_event]

  after_initialize :default_values
  after_create do |event|
    Feed.create_from_object(event, event.creator_id, :event)
  end

  private
  def default_values
    self.praised ||= 0
  end
end
