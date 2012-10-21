# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "creating users..."
u1 = User.create!(:username => "Adelina", :password => "asdf123", :email => "Adelina@gmail.com", :profile_photo => File.open(File.join(Rails.root,'/app/assets/images/profile_photos/profile1.jpg')))
puts "user Adelina created"
u2 = User.create!(:username => "Iracema", :password => "asdf123", :email => "Iracema@gmail.com", :profile_photo => File.open(File.join(Rails.root,'/app/assets/images/profile_photos/profile2.jpg')))
puts "user Iracema created"
u3 = User.create!(:username => "Izabel", :password => "asdf123", :points => 0, :email => "Izabel@gmail.com", :profile_photo => File.open(File.join(Rails.root,'/app/assets/images/profile_photos/profile3.jpg')))
puts "user Izabel created"
u4 = User.create!(:username => "Tereza", :password => "asdf123", :email => "Tereza@gmail.com", :profile_photo => File.open(File.join(Rails.root,'/app/assets/images/profile_photos/profile1.jpg')))
puts "user Tereza created"
u5 = User.create!(:username => "Severino", :password => "asdf123", :email => "Severino@gmail.com", :profile_photo => File.open(File.join(Rails.root,'/app/assets/images/profile_photos/profile4.jpg')))
puts "user Severino created"
u6 = User.create!(:username => "Carolina", :password => "asdf123", :email => "Ana@gmail.com", :profile_photo => File.open(File.join(Rails.root,'/app/assets/images/profile_photos/profile2.jpg')))
puts "user Carolina created"
u7 = User.create!(:username => "Carminha", :password => "asdf123", :email => "Carminha@gmail.com", :profile_photo => File.open(File.join(Rails.root,'/app/assets/images/profile_photos/profile5.jpg')))
puts "user Carminha created"
u8 = User.create!(:username => "Eliana", :password => "asdf123", :email => "Eliana@gmail.com", :profile_photo => File.open(File.join(Rails.root,'/app/assets/images/profile_photos/profile6.jpg')))
puts "user Eliana created"
u9 = User.create!(:username => "Everaldo", :password => "asdf123", :email => "Everaldo@gmail.com", :profile_photo => File.open(File.join(Rails.root,'/app/assets/images/profile_photos/profile4.jpg')))
puts "user Everaldo created"
u10 = User.create!(:username => "Fatima", :password => "asdf123", :email => "Fatima@gmail.com", :profile_photo => File.open(File.join(Rails.root,'/app/assets/images/profile_photos/profile5.jpg')))
puts "user Fátima created"
u11 = User.create!(:username => "Rubens", :password => "asdf123", :email => "Rubens@gmail.com")
puts "user Rubens created"
u12 = User.create!(:username => "Milton", :password => "asdf123", :email => "Milton@gmail.com")
puts "user Milton created"
u13 = User.create!(:username => "Marlene", :password => "asdf123", :email => "Marlene@gmail.com")
puts "user Marlene created"
u14 = User.create!(:username => "Luiza", :password => "asdf123", :email => "Luiza@gmail.com")
puts "user Luiza created"
u15 = User.create!(:username => "Jackson", :password => "asdf123", :email => "Jackson@gmail.com")
puts "user Jackson created"
u16 = User.create!(:username => "flavio", :password => "asdf123", :email => "flavio@gmail.com")
puts "user Chris created"
u17 = User.create!(:username => "Melody", :password => "asdf123", :email => "Melody@gmail.com")
puts "user Melody created"
u18 = User.create!(:username => "Eugene", :password => "asdf123", :email => "Eugene@gmail.com")
puts "user Eugene created"
u19 = User.create!(:username => "Timothy", :password => "asdf123", :email => "Timothy@gmail.com")
puts "user Timothy created"
u20 = User.create!(:username => "Lillian", :password => "asdf123", :email => "Lillian@gmail.com")
puts "user Lillian created"
u21 = User.create!(:username => "Marsh", :password => "asdf123", :email => "Marsh@gmail.com")
puts "user Marsh created"
u22 = User.create!(:username => "Travis", :password => "asdf123", :email => "Travis@gmail.com")
puts "user Travis created"
u23 = User.create!(:username => "Jeffery", :password => "asdf123", :email => "Jeffery@gmail.com")
puts "user Jeffery created"
u24 = User.create!(:username => "Jason", :password => "asdf123", :email => "Jason@gmail.com")
puts "user Jason created"
u25 = User.create!(:username => "Philip", :password => "asdf123", :email => "Philip@gmail.com")
puts "user Philip created"
u26 = User.create!(:username => "Kenny", :password => "asdf123", :email => "Kenny@gmail.com")
puts "user Kenny created"
u27 = User.create!(:username => "Serena", :password => "asdf123", :email => "Serena@gmail.com")
puts "user Serena created"
u28 = User.create!(:username => "Stella", :password => "asdf123", :email => "Stella@gmail.com")
puts "user Stella created"
u29 = User.create!(:username => "Debora", :password => "asdf123", :email => "Debora@gmail.com")
puts "user Debora created"
u30 = User.create!(:username => "Hurst", :password => "asdf123", :email => "Hurst@gmail.com")
puts "user Hurst created"
u31 = User.create!(:username => "Benjamin", :password => "asdf123", :email => "dragonben@hotmail.com")
puts "user Ben created"
puts "all users created\n\n"

puts "creating locations for houses..."
l1 = Location.find_or_create("Maré, Brazil")
puts "Maré - Pina, Recife - Pernambuco, Brazil"

l2 = Location.find_or_create("Rua Adonis de Souza 500, Recife - Pernambuco, Brazil")
puts "Rua Adonis de Souza 500, Recife - Pernambuco, Brazil"

l3 = Location.find_or_create("Rua Adonis de Souza 110, Recife - Pernambuco, Brazil")
puts "Rua Adonis de Souza 110, Recife - Pernambuco, Brazil"

l4 = Location.find_or_create("Rua Adonis de Souza 600, Recife - Pernambuco, Brazil")
puts "Rua Adonis de Souza 600, Recife - Pernambuco, Brazil"

l5 = Location.find_or_create("Avenida Jamil Asfora, 600, Recife - Pernambuco, Brazil")
puts "Avenida Jamil Asfora, 600, Recife - Pernambuco, Brazil"

l6 = Location.find_or_create("Avenida Jamil Asfora, 700, Recife - Pernambuco, Brazil")
puts "Avenida Jamil Asfora, 600, Recife - Pernambuco, Brazil"

l7 = Location.find_or_create("Rua Adonis de Souza 122, Recife - Pernambuco, Brazil")
puts "Rua Adonis de Souza 122, Recife - Pernambuco, Brazil"

l8 = Location.find_or_create("Rua Adonis de Souza 124, Recife - Pernambuco, Brazil")
puts "Rua Adonis de Souza 124, Recife - Pernambuco, Brazil"

l9 = Location.find_or_create("Rua Adonis de Souza 126, Recife - Pernambuco, Brazil")
puts "Rua Adonis de Souza 126, Recife - Pernambuco, Brazil"

l10 = Location.find_or_create("Rua Adonis de Souza 128, Recife - Pernambuco, Brazil")
puts "Rua Adonis de Souza 128, Recife - Pernambuco, Brazil"

l11 = Location.find_or_create("Rua Adonis de Souza 130, Recife - Pernambuco, Brazil")
puts "Rua Adonis de Souza 130, Recife - Pernambuco, Brazil"

l12 = Location.find_or_create("Rua Adonis de Souza 133, Recife - Pernambuco, Brazil")
puts "Rua Adonis de Souza 133, Recife - Pernambuco, Brazil"

l13 = Location.find_or_create("Rua Adonis de Souza 136, Recife - Pernambuco, Brazil")
puts "Rua Adonis de Souza 136, Recife - Pernambuco, Brazil"

l14 = Location.find_or_create("Rocinha, Sao Paulo, Brasil")
puts "Rocinha, Sao Paulo, Brasil"

l15 = Location.find_or_create("Alemao 120, brazil")
puts "Alemao 120, brazil"

l16 = Location.find_or_create("Alemão - Rio Grande do Norte, Brazil")
puts "Alemao 100, brazil"

puts "creating locations for reports"

l17 = Location.find_or_create("Rua Sgt. Silva Nunes, 1012 Ramos, Rio de Janeiro")
puts "Rua Sgt. Silva Nunes, 1012 Ramos, Rio de Janeiro"

l18 = Location.find_or_create("Rua Sgt. Silva Nunes, 140 Ramos, Rio de Janeiro")
puts "Rua Sgt. Silva Nunes, 140 Ramos, Rio de Janeiro"

l19 = Location.find_or_create("Rua Sgt. Silva Nunes, 130 Ramos, Rio de Janeiro")
puts "Rua Sgt. Silva Nunes, 130 Ramos, Rio de Janeiro"

l20 = Location.find_or_create("Rua Sgt. Silva Nunes, 100 Ramos, Rio de Janeiro")
puts "Rua Sgt. Silva Nunes, 100 Ramos, Rio de Janeiro"

l21 = Location.find_or_create("Rua Sgt. Silva Nunes, 120 Ramos, Rio de Janeiro")
puts "Rua Sgt. Silva Nunes, 120 Ramos, Rio de Janeiro"

l22 = Location.find_or_create("Rua Sgt. Silva Nunes, 150 Ramos, Rio de Janeiro")
puts "Rua Sgt. Silva Nunes, 150 Ramos, Rio de Janeiro"

l23 = Location.find_or_create("Rua Sgt. Silva Nunes, 160 Ramos, Rio de Janeiro")
puts "Rua Sgt. Silva Nunes, 160 Ramos, Rio de Janeiro"

l24 = Location.find_or_create("Rua Sgt. Silva Nunes, 170 Ramos, Rio de Janeiro")
puts "Rua Sgt. Silva Nunes, 170 Ramos, Rio de Janeiro"

l25 = Location.find_or_create("Rua Sgt. Silva Nunes, 180 Ramos, Rio de Janeiro")
puts "Rua Sgt. Silva Nunes, 180 Ramos, Rio de Janeiro"

l26 = Location.find_or_create("Rua Sgt. Silva Nunes, 190 Ramos, Rio de Janeiro")
puts "Rua Sgt. Silva Nunes, 190 Ramos, Rio de Janeiro"

l27 = Location.find_or_create("Rua Sgt. Silva Nunes, 200 Ramos, Rio de Janeiro")
puts "Rua Sgt. Silva Nunes, 200 Ramos, Rio de Janeiro"

l28 = Location.find_or_create("Rua Sgt. Silva Nunes, 220 Ramos, Rio de Janeiro")
puts "Rua Sgt. Silva Nunes, 220 Ramos, Rio de Janeiro"

l29 = Location.find_or_create("Rua Sgt. Silva Nunes, 230 Ramos, Rio de Janeiro")
puts "Rua Sgt. Silva Nunes, 230 Ramos, Rio de Janeiro"

puts "all locations created"



puts "creating houses..."
h1 = House.create!(:name => "Casa Adelina", :location_id => l1.id, :profile_photo => File.open(File.join(Rails.root, '/app/assets/images/houses/Casa Adelina.jpg')))
h1.members << u1
h1.save!
puts "Casa Adelina created"

h2 = House.create!(:name => "Casa Tereza", :location_id => l2.id, :profile_photo => File.open(File.join(Rails.root, '/app/assets/images/houses/Casa Tereza.jpg')))
h2.members << u4
h2.save!
puts "Casa Tereza created"

h3 = House.create!(:name => "Casa Carolina", :location_id => l3.id, :profile_photo => File.open(File.join(Rails.root, '/app/assets/images/houses/Casa Ana.jpg')))
h3.members << u6
h3.save!
puts "Casa Carolina created"

h4 = House.create!(:name => "Casa Severino", :location_id => l4.id, :profile_photo => File.open(File.join(Rails.root, '/app/assets/images/houses/Casa Severino.jpg')))
h4.members << u5
h4.save!
puts "Casa Severino created"

h5 = House.create!(:name => "Casa Carminha", :location_id => l5.id, :profile_photo => File.open(File.join(Rails.root, '/app/assets/images/houses/Casa Carminha.jpg')))
h5.members << u7
h5.save!
puts "Casa Carminha created"

h6 = House.create!(:name => "Casa Rubens", :location_id => l6.id, :profile_photo => File.open(File.join(Rails.root, '/app/assets/images/houses/Casa Rubens.jpg')))
h6.members << u11
h6.save!
puts "Casa Rubens created"

h7 = House.create!(:name => "Casa Eliana", :location_id => l7.id, :profile_photo => File.open(File.join(Rails.root, '/app/assets/images/houses/Casa Eliana.jpg')))
h7.members << u8
h7.save!
puts "Casa Eliana created"

h8 = House.create!(:name => "Casa Milton", :location_id => l8.id, :profile_photo => File.open(File.join(Rails.root, '/app/assets/images/houses/Casa Milton.jpg')))
h8.members << u12
h8.save!
puts "Casa Milton created"

h9 = House.create!(:name => "Casa Everaldo", :location_id => l9.id, :profile_photo => File.open(File.join(Rails.root, '/app/assets/images/houses/Casa Everaldo.jpg')))
h9.members << u9
h9.save!
puts "Casa Everaldo created"

h10 = House.create!(:name => "Casa Marlene", :location_id => l10.id, :profile_photo => File.open(File.join(Rails.root, '/app/assets/images/houses/Casa Marlene.jpg')))
h10.members << u13
h10.save!
puts "Casa Marlene created"

h11 = House.create!(:name => "Casa Fatima", :location_id => l11.id, :profile_photo => File.open(File.join(Rails.root, '/app/assets/images/houses/Casa Fatima.jpg')))
h11.members << u10
h11.save!
puts "Casa Fatima created"

h12 = House.create!(:name => "Casa Luiza", :location_id => l12.id, :profile_photo => File.open(File.join(Rails.root, '/app/assets/images/houses/Casa Luiza.jpg')))
h12.members << u14
h12.save!
puts "Casa Luiza created"

h13 = House.create!(:name => "Casa Josa", :location_id => l13.id, :profile_photo => File.open(File.join(Rails.root, '/app/assets/images/houses/Casa Josa.jpg')))
h13.members << u13
puts "Casa Josa created"

h14 = House.create!(:name => "Casa Ana", :location_id => l14.id, :profile_photo => File.open(File.join(Rails.root, '/app/assets/images/houses/Casa Iracema.jpg')))
h14.members << u14
h14.save!
puts "Casa Ana"

#h15 = House.create!(:name => "Casa Lucas", :location_id => l15.id, :profile_photo => File.open(File.join(Rails.root, '/app/assets/images/houses/Casa Iracema.jpg')))
#h15.members << u29
#puts "Casa Ana"

h16 = House.create!(:name => "Casa flavio", :location_id => l16.id, :profile_photo => File.open(File.join(Rails.root, '/app/assets/images/houses/Casa Iracema.jpg')))
h16.members << u16
puts "Casa flavio"

puts "all houses created and members added"
 
 
puts "creating open reports..."
r1 = Report.create_from_user("I saw many containers in this junk yard. They need some cleaning.", :status => :reported, :reporter => u1, :location => l14, :before_photo => File.open(File.join(Rails.root,'/app/assets/images/report_photos/report2_1.jpg')))
r1.save!

r2 = Report.create_from_user("The garden in the school requires some help.", :status => :claimed, :reporter => u1, :location => l15, :before_photo => File.open(File.join(Rails.root,'/app/assets/images/report_photos/report2_1.jpg')))
r2.claimer = u1
r2.save!

r3 = Report.create_from_user("Please take a look at the big garbage can next to the pole.", :status => :reported, :reporter => u1, :location => l16, :before_photo => File.open(File.join(Rails.root,'/app/assets/images/report_photos/report3_1.jpg' )))
r3.save!

r4 = Report.create_from_user("There are some pupae in the container.", :status => :eliminated, :reporter => u1, :location => l17, :before_photo => File.open(File.join(Rails.root,'/app/assets/images/report_photos/report2_1.jpg')), :after_photo => File.open(File.join(Rails.root,'/app/assets/images/report_photos/report2_2.jpg')))
r4.claimer = u1
r4.eliminator = u1
r4.save!

r5 = Report.create_from_user("The sewer contains water after rainning season", :status => :claimed, :reporter => u1, :location => l18)
r5.claimer = u1
r5.save!

r6 = Report.create_from_user("There are some pupae in the container.", :status => :claimed, :reporter => u1, :location => l19)
r6.claimer = u1
r6.save!

r2 = Report.create_from_user("In the pot next to the vending machine, there are some pupae.", :status => :reported, :reporter => u1, :location => l20)
r2.save!

r3 = Report.create_from_user("Next to the sever-eleven, there is a garbage can that has water in it.", :status => :reported, :reporter => u2, :location => l21)
r3.save!

r4 = Report.create_from_user("In my backyard, I kept several water containers that I need to clean myself.", :status => :eliminated, :reporter => u11, :location => l22)
r4.claimer = u1
r4.eliminator = u1
r4.save!

r5 = Report.create_from_user("I saw some water dents after raining, and pupae are growing.", :status => :eliminated, :reporter => u1, :location => l23)
r5.claimer = u2
r5.eliminator = u2
r5.save!

r6 = Report.create_from_user("Right next to the school bus stop, there are some garbage cans need to take care of.", :status => :reported, :reporter => u2, :location => l24)
r6.save!

r7 = Report.create_from_user("I have three huge water tanks that I need help with", :status => :eliminated, :reporter => u2, :location => l25)
r7.claimer = u7
r7.eliminator = u7
r7.save!
puts "all reports created"


puts "creating posts..."
e1 = Post.create!(:title => 'My Party', :content => "Over this weekend, I am creating a fight dengue party. I would like to invite everyone to join") do |post| post.wall = u1.house; post.user = u1 end
e2 = Post.create!(:title => 'Dengue Fighting', :content => "I would like to know if there are new technique to eliminate dengue. Would anyone like to share?") do |post| post.wall = u1.house; post.user = u1 end
e3 = Post.create!(:title => 'Great Job!', :content => "Hey guys! Let's keep it up. We are winning over our neighborhoods!") do |post|  post.wall = u1.house; post.user = u2 end
e4 = Post.create!(:title => 'New Discovery!', :content => "Here's a new method I discovered to fight dengue. Everytime you are done with a contain, you should flip it upside down.") do |post| post.wall = u1.house; post.user = u3 end

puts "events and comments created"


puts "resetting the neighborhood name just for the demo"
n1 = Neighborhood.find(1)
n1.name = "Maré"
n1.save!
puts "setting first neighborhood to be Mare"
n2 = Neighborhood.find(2)
n2.name = "Alemao"
n2.save!
puts "setting second neighborhood to be Alemao"
n3 = Neighborhood.find(3)
n3.name = "Rocinha"
n3.save!
puts "setting third neighborhood to be Rocinha"



