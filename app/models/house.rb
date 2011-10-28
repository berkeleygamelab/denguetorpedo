class House < ActiveRecord::Base
  has_many :members, :class_name => "User"
  has_many :events, :through => :members
  belongs_to :featured_event, :class_name => "Event"

  def points
    # TODO: change this to use a SQL query because this is probably not that efficient
    members.map {|m| m.points}.sum
  end

  def num_reports
    # TODO: change this to use a SQL query
    reports = Set.new
    for m in members
      reports.merge(m.created_reports)
      reports.merge(m.claimed_reports)
      reports.merge(m.eliminated_reports)
    end

    reports.size
  end
end
