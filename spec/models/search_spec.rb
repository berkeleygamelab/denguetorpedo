require 'spec_helper'

describe Location do
  before :each do
    l1 = Location.find_or_create('2521 Regent St. Berkeley, CA')
    l2 = Location.find_or_create('2525 Regent St. Berkeley, CA')
    l3 = Location.find_or_create('625 N Hill St. Los Angeles, CA')
  end

  it 'can search locations' do
    sleep 2
    
    # simple searches
    searched_locations = Location.search('Regent')
    searched_locations.count.should == 2
    searched_locations = Location.search('regents')
    searched_locations.count.should == 2
    searched_locations = Location.search('hills.')
    searched_locations.count.should == 1

    # search something that was not in the initial given string
    searched_locations = Location.search('94704')
    searched_locations.count.should == 2
  end

  it 'can search house' do
    sleep 2
    h1 = House.create(:name => "house1") do |house|
      house.location = Location.all[0]
    end
    h2 = House.create(:name => "house2") do |house|
      house.location = Location.all[1]
    end
    h3 = House.create(:name => "house3") do |house|
      house.location = Location.all[2]
    end

    houses = House.search('house')
    houses.count.should == 0

    houses = House.search('house1')
    houses.count.should == 1

    houses = House.search('regents')
    houses.count.should == 2
  end

  it 'can search neighborhods' do
    sleep 2

    neighborhoods = Neighborhood.search('chinatown')
    neighborhoods.count.should == 1

    neighborhoods = Neighborhood.search('elmwood')
    neighborhoods.count.should == 1

    neighborhoods = Neighborhood.search('regents')
    neighborhoods.count.should == 1

    neighborhoods = Neighborhood.search('CA')
    neighborhoods.count.should == 2
  end

  it 'can search posts' do
    sleep 2

    u1 = User.create!(:username => "LukeSkywalker", :password => "asdf123", :email => "foo1@foo.com")
    Post.create(:title => "hello", :content => "World") do |post|
      post.user = u1
    end
    Post.create(:title => "hellos", :content => "World") do |post|
      post.user = u1
    end
    Post.create(:title => "bar", :content => "World") do |post|
      post.user = u1
    end

    Post.search('worlds').count.should == 3
    Post.search('hello').count.should == 2
    Post.search('bar').count.should == 1
  end
end
