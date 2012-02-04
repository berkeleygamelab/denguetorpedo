class House < ActiveRecord::Base
  has_many :members, :class_name => "User"
  has_many :events, :through => :members
  has_many :created_reports, :through => :members
  has_many :claimed_reports, :through => :members
  has_many :eliminated_reports, :through => :members
  belongs_to :featured_event, :class_name => "Event"
  belongs_to :location

  def points
    # TODO: change this to use a SQL query because this is probably not that efficient
    members.map {|m| m.points}.sum
  end

  def reports
    # TODO: change this to use a SQL query
    created_reports | claimed_reports | eliminated_reports
  end
end
