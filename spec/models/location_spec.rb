# == Schema Information
#
# Table name: locations
#
#  id                :integer          not null, primary key
#  nation            :string(255)
#  state             :string(255)
#  city              :string(255)
#  address           :string(255)
#  latitude          :float
#  longitude         :float
#  gmaps             :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  formatted_address :string(255)
#  neighborhood_id   :integer
#

require 'spec_helper'

describe Location do

  it 'creates location from a generic address string' do
    l = Location.find_or_create("2521 Regent St. 94704")
    l.nation.should == "United States"
    l.state.should == "California"
    l.city.should == "Berkeley"
    l.address.should == "2521 Regent St"
    l.neighborhood.name.should == "Elmwood"

    Location.count.should == 1
  end

  it 'can fetch existing locations when one exists' do
    l = Location.find_or_create('2521 Regent St. 94704')
    Location.count.should == 1
    l2 = Location.find_or_create('2655 Griffin Ave 90031')
    Location.count.should == 2
    Neighborhood.count.should == 2
    l3 = Location.find_or_create('2521 Regent St. Berkeley CA 94704')
    l3.should == l
    Location.count.should == 2
    Neighborhood.count.should == 2
  end
end

