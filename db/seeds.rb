# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1 = User.create!(:username => "LukeSkywalker", :password => "asdf123", :email => "foo1@foo.com")
u2 = User.create!(:username => "DarthVader", :password => "asdf123", :email => "foo2@foo.com")
u3 = User.create!(:username => "PrincessLeia", :password => "asdf123", :points => 0, :email => "foo3@foo.com")
u4 = User.create!(:username => "PadmeAmidala", :password => "asdf123", :email => "foo4@foo.com")
u5 = User.create!(:username => "DarthSidious", :password => "asdf123", :email => "foo5@foo.com")
u6 = User.create!(:username => "YodaYoda", :password => "asdf123", :email => "foo6@foo.com")
u7 = User.create!(:username => "HanSolo", :password => "asdf123", :email => "foo7@foo.com")
u8 = User.create!(:username => "QuiGonJinn", :password => "asdf123", :email => "foo8@foo.com")
u9 = User.create!(:username => "R2-D2", :password => "asdf123", :email => "foo9@foo.com")
u10 = User.create!(:username => "C-3PO", :password => "asdf123", :email => "foo10@foo.com")
u11 = User.create!(:username => "ObiWanKenobi", :password => "asdf123", :email => "foo11@foo.com")
puts "users created"

l1 = Location.create!(:address => "2521 Regent St. Berkeley, CA", :neighborhood => Neighborhood.find_or_initialize_by_name("South Side"))
l2 = Location.create!(:address => "1628 Spruce St. Berkeley, CA", :neighborhood => Neighborhood.find_or_initialize_by_name("North Side"))
l3 = Location.create!(:address => "3850 Park Blvd. Oakland, CA", :neighborhood => Neighborhood.find_or_initialize_by_name("Oakland"))
l4 = Location.create!(:address => "2400 Durant Ave. Berkeley, CA", :neighborhood => Neighborhood.find_or_initialize_by_name("South Side"))
l5 = Location.create!(:address => "2627 Hillegass Ave. Berkeley, CA", :neighborhood => Neighborhood.find_or_initialize_by_name("South Side"))
sleep 2
l6 = Location.create!(:address => "2539 Durant Ave. Berkeley, CA", :neighborhood => Neighborhood.find_or_initialize_by_name("South Side"))
l7 = Location.create!(:address => "2525 Regent St. Berkeley, CA", :neighborhood => Neighborhood.find_or_initialize_by_name("South Side"))
l8 = Location.create!(:address => "2424 Channing Way. Berkeley, CA", :neighborhood => Neighborhood.find_or_initialize_by_name("South Side"))
l9 = Location.create!(:address => "1701 Euclid Ave, Berkeley, CA", :neighborhood => Neighborhood.find_or_initialize_by_name("North Side"))
l10 = Location.create!(:address => "2022 Cedar St. Oakland, CA", :neighborhood => Neighborhood.find_or_initialize_by_name("North Side"))
sleep 2
l11 = Location.create!(:address => "479 65th St. Oakland, CA", :neighborhood => Neighborhood.find_or_initialize_by_name("Oakland"))
l12 = Location.create!(:address => "454 Alcatraz Ave. Oakland, CA", :neighborhood => Neighborhood.find_or_initialize_by_name("Oakland"))
l13 = Location.create!(:address => "2702 Stuart St. Berkeley, CA", :neighborhood => Neighborhood.find_or_initialize_by_name("South Side"))
puts "locations created"
sleep 2

h1 = House.create!(:name => "Tatooine", :location_id => l1.id)
h1.members << u1
h1.members << u11
h1.members << u8
h1.members << u10
h1.save!

h2 = House.create!(:name => "Dagoba", :location_id => l2.id)
h2.members << u6
h2.save!

h3 = House.create!(:name => "Millenium Falcon", :location_id => l3.id)
h3.members << u7
h3.save!

h4 = House.create!(:name => "Naboo", :location_id => l5.id)
h4.members << u4
h4.members << u3
h4.members << u9
h4.save!

h5 = House.create!(:name => "Death Star", :location_id => l4.id)
h1.members << u2
h5.members << u5
h5.save!

h6 = House.create!(:name => "foo1", :location_id => l6.id)
h7 = House.create!(:name => "foo2", :location_id => l7.id)
h8 = House.create!(:name => "foo3", :location_id => l8.id)
h9 = House.create!(:name => "foo4", :location_id => l9.id)
h10 = House.create!(:name => "foo5", :location_id => l10.id)
h11 = House.create!(:name => "foo6", :location_id => l11.id)
h12 = House.create!(:name => "foo7", :location_id => l12.id)
h13 = House.create!(:name => "foo8", :location_id => l13.id)

puts "members added"

r1 = Report.create!(:report => "Let's rescue Princess Leia!", :status => :claimed, :reporter_id => u1.id, :location_id => u1.house.location.id)
r1.claimer = u1
r1.save!
r2 = Report.create!(:report => "I find your lack of faith...disturbing...", :status => :claimed, :reporter_id => u2.id, :location_id => u2.house.location.id)
r2.claimer = u2
r2.save!
r3 = Report.create!(:report => "Use the force...", :status => :reported, :reporter_id => u6.id, :location_id => u6.house.location.id)
r3.save!
r4 = Report.create!(:report => "If you strike me down, I shall become more powerful that you ever imagine.", :status => :claimed, :reporter_id => u11.id, :location_id => -1)
r4.location = Location.create!(:address => "474 66th St. Oakland, CA", :neighborhood => Neighborhood.find_or_initialize_by_name("Oakland"))
r4.claimer = u2
r4.save!
r5 = Report.create!(:report => "Luck...I am your father...", :status => :eliminated, :reporter_id => u2.id, :location_id => -1)
r5.claimer = u2
r5.eliminator = u2
r5.location = Location.create!(:address => "1860 Leroy Ave. Berkeley, CA", :neighborhood => Neighborhood.find_or_initialize_by_name("Oakland"))
r5.save!
r6 = Report.create!(:report => "Beep Beep Beep Beep...", :status => :reported, :reporter_id => u9.id, :location_id => u9.house.location.id)
r6.save!
r7 = Report.create!(:report => "Made the kesser run in less than twelve parsecs", :status => :eliminated, :reporter_id => u7.id, :location_id => u7.house.location.id)
r7.claimer = u7
r7.eliminator = u10
r7.save!
puts "reports created"

e1 = Event.create!(:creator_id => u1.id, :description => "destroy the death star!", :praised => 1, :category => :special_event)
e1.comments << EventComment.new(:content => "we need to do it fast!", :user_id => u1.id)
e1.comments << EventComment.new(:content => "let's deliver a torpedo to the center of the death star.", :user_id => u7.id)
Event.create(:creator_id => u11.id, :description => "train Luke as a Jedi", :praised => true, :category => :story)
e1.comments << EventComment.new(:content => "don't use your eyes", :user_id => u11.id)
e1.comments << EventComment.new(:content => "be angry, you must not", :user_id => u6.id)
Event.create(:creator_id => u5.id, :description => "convert Anakin to the dark side", :category => :special_event)
puts "events and comments created"

