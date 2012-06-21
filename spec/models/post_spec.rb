require 'spec_helper'

describe Post do
  it "can create simple posts" do
    u1 = User.create!(:username => "LukeSkywalker", :password => "asdf123", :email => "foo1@foo.com")
    p1 = Post.create :content => "testing", :user_id => u1.id
    p2 = Post.create :content => "testing1", :user_id => u1.id
    p3 = Post.create :content => "testing2", :user_id => u1.id
    p4 = Post.create :content => "testing3", :user_id => u1.id

    Post.count.should == 4
    for p in Post.all
      p.siblings.count.should == 3
      p.parent.should == nil
      p.children.count.should == 0
      p.user.should == u1
    end

    Feed.count.should == 4
  end

  it "can have ancestors and descendants" do
    u1 = User.create!(:username => "LukeSkywalker", :password => "asdf123", :email => "foo1@foo.com")
    p1 = Post.create :content => "testing", :user_id => u1.id
    p2 = Post.create :content => "testing1", :user_id => u1.id, :parent_id => p1.id
    p3 = Post.create :content => "testing2", :user_id => u1.id, :parent_id => p1.id
    p4 = Post.create :content => "testing3", :user_id => u1.id, :parent_id => p2.id
    p5 = Post.create :content => "testing3", :user_id => u1.id, :parent_id => p4.id
    p6 = Post.create :content => "testing3", :user_id => u1.id

    [p1, p2, p3, p4, p5, p6].each do |p|
      p.reload
      p.user.should == u1
    end

    p1.parent.should == nil
    p1.children.count.should == 2
    p1.children.should include(p2, p3)
    p1.descendants.count.should == 4
    p1.descendants.should include(p2, p3, p4, p5)
    p2.children.count.should == 1
    p2.children.should include(p4)
    p2.parent.should == p1
    p5.ancestors.count.should == 3
    p6.parent.should == nil
    p6.children.count.should == 0

    Feed.count.should == 6
  end

  it "should fail validations" do
    p = Post.create :content => "asdfsdf"
    p.valid?.should be_false

    p = Post.create :user_id => 1
    p.valid?.should be_false

    p = Post.create :content => "sfsdf", :user_id => 1
    p.valid?.should be_true
  end

  it "can belong to a wall" do
    u1 = User.create!(:username => "LukeSkywalker", :password => "asdf123", :email => "foo1@foo.com")
    u2 = User.create!(:username => "YodaYoda", :password => "asdf123", :email => "foo2@foo.com")
    l1 = Location.find_or_create("2521 Regent St. Berkeley, CA")
    l2 = Location.find_or_create("1628 Spruce St. Berkeley, CA")
    h1 = House.create!(:name => "Tatooine", :location_id => l1.id)
    h2 = House.create!(:name => "Dagoba", :location_id => l2.id)
    h1.members << u1
    h2.members << u2

    p1 = Post.create!(:title => "baaa", :content => "I'm a cow") do |p|
      p.user = u1
      p.wall = h1
    end
    p2 = Post.create!(:title => "meow", :content => "I'm a cat") do |p|
      p.user = u2
      p.wall = h2
    end
    p3 = Post.create!(:title => ":)", :content => "I'm a human") do |p|
      p.user = u1
      p.wall = h2
    end

    h1.posts.count.should == 1
    h2.posts.count.should == 2
    h1.posts.should include(p1)
    h2.posts.should include(p2)
    h2.posts.should include(p3)
  end
end
