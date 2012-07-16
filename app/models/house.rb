class House < ActiveRecord::Base
  attr_accessible :name, :profile_photo
  
  has_attached_file :profile_photo, :styles => {:small => "60x60>", :medium => "150x150>" , :large => "225x225>"}, :default_url => 'default_images/house_default_image.png'

  has_many :members, :class_name => "User"
  has_many :posts, :as => :wall
  has_many :created_reports, :through => :members
  has_many :claimed_reports, :through => :members
  has_many :eliminated_reports, :through => :members
  belongs_to :location

  accepts_nested_attributes_for :location, :allow_destroy => true
  attr_accessible :location_id, :location_attributes

  validates :location_id, presence: true, uniqueness: true

  def neighborhood
    location.neighborhood
  end
  
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

  def self.find_or_create(name, address, profile_photo=nil)
    return nil if name.nil? || name.blank?

    # try to find the house, and return if it exists
    house = House.find_by_name(name)
    if house
      house.profile_photo = profile_photo
      house.save
      return house
    end

    return nil if address.nil? || address.blank?

    # create the location
    location = Location.find_or_create(address)
    if location.nil?
      return nil
    end
    house = House.find_by_location_id(location.id)
    if house
      house.profile_photo = profile_photo
      house.save
      return house
    end

    # create the house
    house = House.new(name: name)
    house.location = location
    house.profile_photo = profile_photo
    house.save

    # return the new house
    return house
  end
end
