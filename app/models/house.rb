class House < ActiveRecord::Base
  attr_accessible :name

  has_many :members, :class_name => "User"
  has_many :posts, :through => :members
  has_many :created_reports, :through => :members
  has_many :claimed_reports, :through => :members
  has_many :eliminated_reports, :through => :members
  belongs_to :location

  validates :location_id, :presence => true

  def neighborhood
    location.neighborhood
  end

  accepts_nested_attributes_for :location, :allow_destroy => true
  attr_accessible :location_id, :location_attributes

  validates :location_id, :presence => true
  validates :location_id, :uniqueness => true

  def points
    members.sum(:points)
  end

  def complete_address
    self.location.complete_address
  end

  def reports
    _reports = Report.find_by_sql(%Q(SELECT DISTINCT "reports".* FROM "reports", "users" WHERE (("reports".reporter_id = "users".id OR "reports".claimer_id = "users".id OR "reports".eliminator_Id = "users".id) AND "users".house_id = #{id}) ORDER BY "reports".updated_at DESC))
    ActiveRecord::Associations::Preloader.new(_reports, [:location]).run
    _reports
  end
  
end
