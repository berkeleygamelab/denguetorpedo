# == Schema Information
#
# Table name: neighborhoods
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  coordinator_id :integer
#

class Neighborhood < ActiveRecord::Base
  attr_accessible :name

  has_many :locations
  has_many :houses, :through => :locations
  has_many :members, :through => :houses
  has_many :reports, :through => :locations
  belongs_to :coordinator, :class_name => "User"
  has_many :health_agents, :through => :houses, :source => "members", :conditions => "is_health_agent = 1"

  validates :name, :presence => true

  def rank
    0
  end
  
  def total_reports
    total_reports = []
    self.members.each do |member|
      member.reports.each do |report|
        total_report = total_reports.append(report)
      end
    end
    total_reports
  end
  
  def open_reports
    open_reports = []
    self.members.each do |member|
      member.reports.each do |report|
        open_report = open_reports.append(report) if report.status == :reported
      end
    end
    open_reports
  end
    
  def eliminated_reports
    eliminated_reports = []
    self.members.each do |member|
      member.reports.each do |report|
        eliminated_report = eliminated_reports.append(report) if report.status == :eliminated
      end
    end
    eliminated_reports
  end
  
end
