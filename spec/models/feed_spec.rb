require 'spec_helper'

describe Feed do

  it "create feeds when reports are created and changed" do
    u1 = User.create!(:username => "LukeSkywalker", :password => "asdf123", :email => "foo1@foo.com")
    u2 = User.create!(:username => "DarthVader", :password => "asdf123", :email => "foo2@foo.com")
    l1 = Location.create!(:address => "2521 Regent St. Berkeley, CA", :neighborhood => Neighborhood.find_or_initialize_by_name("South Side"))

    r1 = Report.create(:report => "foo", :reporter_id => u1.id, :claimer_id => u1.id, :location_id => l1)
    Feed.count.should == 2
    r1.eliminator_id = u2.id
    r1.save
    Feed.count.should == 3

    feeds = Feed.all
    feeds[0].target.should == r1
    feeds[0].feed_type.should == :reported
    feeds[0].user_id.should == u1.id
    feeds[1].target.should == r1
    feeds[1].feed_type.should == :claimed
    feeds[1].user_id.should == u1.id
    feeds[2].target.should == r1
    feeds[2].feed_type.should == :eliminated
    feeds[2].user_id.should == u2.id
  end

  
  it "create feeds when events and event comments are created" do
    u1 = User.create!(:username => "LukeSkywalker", :password => "asdf123", :email => "foo1@foo.com")
    u2 = User.create!(:username => "DarthVader", :password => "asdf123", :email => "foo2@foo.com")

    e1 = Event.create(:creator_id => u1.id, :description => "foo", :category => :special_event)
    Feed.count.should == 1

    e1.comments << EventComment.new(:content => "asdf", :user_id => u1.id)
    e1.comments << EventComment.new(:content => "asdf", :user_id => u2.id)
    Feed.count.should == 3

    feeds = Feed.all
    feeds[0].target.should == e1
    feeds[0].feed_type.should == :event
    feeds[0].user.should == u1
    feeds[1].target.should == e1.comments[0]
    feeds[1].feed_type.should == :event_comment
    feeds[1].user.should == u1
    feeds[2].target.should == e1.comments[1]
    feeds[2].feed_type.should == :event_comment
    feeds[2].user.should == u2
  end
end
