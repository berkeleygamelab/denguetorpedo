require 'spec_helper'

describe Feed do

  it "create feeds when reports are created and changed" do
    u1 = User.create!(:username => "LukeSkywalker", :password => "asdf123", :email => "foo1@foo.com")
    u2 = User.create!(:username => "DarthVader", :password => "asdf123", :email => "foo2@foo.com")
    l1 = Location.find_or_create("2521 Regent St. Berkeley, CA")
    l1.id.should == 1

    r1 = Report.create_from_user("foo", :reporter => u1, :claimer => u1, :location => l1, :status => :claimed)
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

  
  it "create feeds when posts are created" do
    u1 = User.create!(:username => "LukeSkywalker", :password => "asdf123", :email => "foo1@foo.com")
    u2 = User.create!(:username => "DarthVader", :password => "asdf123", :email => "foo2@foo.com")

    p = Post.create(:user_id => u1.id, :content => "foo")
    Feed.count.should == 1

    p.children << Post.new(:content => "asdf", :user_id => u1.id)
    p.children << Post.new(:content => "asdf", :user_id => u2.id)
    Feed.count.should == 3

    feeds = Feed.all
    feeds[0].target.should == p
    feeds[0].feed_type.should == :post
    feeds[0].user.should == u1
    p.feed.should == feeds[0]
    feeds[1].target.should == p.children[0]
    feeds[1].feed_type.should == :post
    feeds[1].user.should == u1
    p.children[0].feed.should == feeds[1]
    feeds[2].target.should == p.children[1]
    feeds[2].feed_type.should == :post
    feeds[2].user.should == u2
    p.children[1].feed.should == feeds[2]
  end
end
