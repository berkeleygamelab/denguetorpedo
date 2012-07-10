# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1 = User.create!(:username => "Jacob", :password => "asdf123", :email => "foo1@foo.com")
u2 = User.create!(:username => "Mason", :password => "asdf123", :email => "foo2@foo.com")
u3 = User.create!(:username => "William", :password => "asdf123", :points => 0, :email => "foo3@foo.com")
u4 = User.create!(:username => "Jayden", :password => "asdf123", :email => "foo4@foo.com")
u5 = User.create!(:username => "Johna", :password => "asdf123", :email => "foo5@foo.com")
u6 = User.create!(:username => "Michael", :password => "asdf123", :email => "foo6@foo.com")
u7 = User.create!(:username => "Sophia", :password => "asdf123", :email => "foo7@foo.com")
u8 = User.create!(:username => "Isabella", :password => "asdf123", :email => "foo8@foo.com")
u9 = User.create!(:username => "Emily", :password => "asdf123", :email => "foo9@foo.com")
u10 = User.create!(:username => "Olivia", :password => "asdf123", :email => "foo10@foo.com")
u11 = User.create!(:username => "Angela", :password => "asdf123", :email => "foo11@foo.com")
puts "users created"

l1 = Location.find_or_create("2521 Regent St. Berkeley, CA")
l2 = Location.find_or_create("1628 Spruce St. Berkeley, CA")
l3 = Location.find_or_create("3850 Park Blvd. Oakland, CA")
l4 = Location.find_or_create("2400 Durant Ave. Berkeley, CA")
l5 = Location.find_or_create("2627 Hillegass Ave. Berkeley, CA")
sleep 2

l6 = Location.find_or_create("2539 Durant Ave. Berkeley, CA")
l7 = Location.find_or_create("2525 Regent St. Berkeley, CA")
l8 = Location.find_or_create("2424 Channing Way. Berkeley, CA")
l9 = Location.find_or_create("1701 Euclid Ave, Berkeley, CA")
l10 = Location.find_or_create("2022 Cedar St. Oakland, CA")
sleep 2

l11 = Location.find_or_create("479 65th St. Oakland, CA")
l12 = Location.find_or_create("454 Alcatraz Ave. Oakland, CA")
l13 = Location.find_or_create("2702 Stuart St. Berkeley, CA")
sleep 2

puts "locations created"


h1 = House.create!(:name => "Jacob's House", :location_id => l1.id)
h1.members << u1
h1.members << u11
h1.members << u8
h1.save!

h2 = House.create!(:name => "Michael's House", :location_id => l2.id)
h2.members << u6
h2.save!

h3 = House.create!(:name => "Sophia's", :location_id => l3.id)
h3.members << u7
h3.save!

h4 = House.create!(:name => "Jayden's", :location_id => l5.id)
h4.members << u4
h4.members << u3
h4.save!

h5 = House.create!(:name => "Mason's", :location_id => l4.id)
h5.members << u2
h5.save!

h6 = House.create!(:name => "Evan's manor", :location_id => l6.id)
h6.members << u9
h6.save!

h7 = House.create!(:name => "Regent Apartment", :location_id => l7.id)
h7.members << u10
h7.save!

h8 = House.create!(:name => "Channing Apartment", :location_id => l8.id)
h8.members << u5
h8.save!

h9 = House.create!(:name => "Euclid House", :location_id => l9.id)

h10 = House.create!(:name => "Oakland Complex", :location_id => l10.id)

h11 = House.create!(:name => "Marshal Housing", :location_id => l11.id)

h12 = House.create!(:name => "Alcatraz Apt.", :location_id => l12.id)

h13 = House.create!(:name => "Stuart Apt.", :location_id => l13.id)

puts "members added"
 
r1 = Report.create_from_user("There are some pupae in the container.", :status => :claimed, :reporter => u1, :location => u1.house.location)
r1.claimer = u1
r1.save!

r2 = Report.create_from_user("In the pot next to the vending machine, there are some pupae.", :status => :claimed, :reporter => u2, :location => u2.house.location)
r2.claimer = u2
r2.save!

r3 = Report.create_from_user("Next to the sever-eleven, there is a garbage can that has water in it.", :status => :reported, :reporter => u6, :location => u6.house.location)
r3.save!

r4 = Report.create_from_user("In my backyard, I kept several water containers that I need to clean myself.", :status => :claimed, :reporter => u11, :location => l12)
r4.location = Location.find_or_create("474 66th St. Oakland, CA")
r4.claimer = u2
r4.save!

r5 = Report.create_from_user("I saw some water dents after raining, and pupae are growing.", :status => :eliminated, :reporter => u2, :location => l11)
r5.claimer = u2
r5.eliminator = u2
r5.location = Location.find_or_create("1860 Leroy Ave. Berkeley, CA")
r5.save!

r6 = Report.create_from_user("Right next to the school bus stop, there are some garbage cans need to take care of.", :status => :reported, :reporter => u9, :location => u9.house.location)
r6.save!

r7 = Report.create_from_user("I have three huge water tanks that I need help with", :status => :eliminated, :reporter => u7, :location => u7.house.location)
r7.claimer = u7
r7.eliminator = u10
r7.save!

puts "reports created"


e1 = Post.create!(:user_id => u1.id, :content => "Over this weeken, I am creating a fight dengue party. I would like to invite everyone to join")
e1.children << Post.new(:content => "I would like to know if there are new technique to eliminate dengue. Would anyone like to share?", :user_id => u1.id)
e1.children << Post.new(:content => "Hey guys! Let's keep it up. We are winning over our neighborhoods!", :user_id => u7.id)
e2 = Post.create(:user_id => u11.id, :content => "Here's a new method I discovered to fight dengue. Everytime you are done with a contain, you should flip it upside down.")
e2.children << Post.new(:content => "I don't have any plan this weekend. Anyone would like to get together for a beer?", :user_id => u11.id)
e2.children << Post.new(:content => "I am debating on what kind rewards to redeem. Anyone any suggestion?", :user_id => u6.id)
e3 = Post.create(:user_id => u5.id, :content => "Looks like the health agent has contacted me that this season the breakout rate has slowed down!")

puts "events and comments created"

