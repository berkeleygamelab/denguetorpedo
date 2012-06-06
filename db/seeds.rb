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

puts 
r1 = Report.create_from_user("Let's rescue Princess Leia!", :status => :claimed, :reporter => u1, :location => u1.house.location)
r1.claimer = u1
r1.save!
r2 = Report.create_from_user("I find your lack of faith...disturbing...", :status => :claimed, :reporter => u2, :location => u2.house.location)
r2.claimer = u2
r2.save!
r3 = Report.create_from_user("Use the force...", :status => :reported, :reporter => u6, :location => u6.house.location)
r3.save!
r4 = Report.create_from_user("If you strike me down, I shall become more powerful that you ever imagine.", :status => :claimed, :reporter => u11, :location => l12)
r4.location = Location.find_or_create("474 66th St. Oakland, CA")
r4.claimer = u2
r4.save!
r5 = Report.create_from_user("Luck...I am your father...", :status => :eliminated, :reporter => u2, :location => l11)
r5.claimer = u2
r5.eliminator = u2
r5.location = Location.find_or_create("1860 Leroy Ave. Berkeley, CA")
r5.save!
r6 = Report.create_from_user("Beep Beep Beep Beep...", :status => :reported, :reporter => u9, :location => u9.house.location)
r6.save!
r7 = Report.create_from_user("Made the kesser run in less than twelve parsecs", :status => :eliminated, :reporter => u7, :location => u7.house.location)
r7.claimer = u7
r7.eliminator = u10
r7.save!
puts "reports created"

e1 = Post.create!(:user_id => u1.id, :content => "destroy the death star!")
e1.children << Post.new(:content => "we need to do it fast!", :user_id => u1.id)
e1.children << Post.new(:content => "let's deliver a torpedo to the center of the death star.", :user_id => u7.id)
e2 = Post.create(:user_id => u11.id, :content => "train Luke as a Jedi")
e2.children << Post.new(:content => "don't use your eyes", :user_id => u11.id)
e2.children << Post.new(:content => "be angry, you must not", :user_id => u6.id)
e3 = Post.create(:user_id => u5.id, :content => "convert Anakin to the dark side")
puts "events and comments created"

