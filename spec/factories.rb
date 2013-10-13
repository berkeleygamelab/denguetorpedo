FactoryGirl.define do
	factory :user do |user|
		user.first_name { Faker::Name.first_name }
		user.last_name { Faker::Name.last_name }
		user.email { Faker::Internet.email }
		user.phone_number { Faker::PhoneNumber.phone_number[0..19] }
		user.password "denguewarrior"
		user.password_confirmation "denguewarrior"
	end

	factory :prize do |prize|
		prize.prize_name "Prize"
		prize.cost 100
		prize.stock 100
		prize.description "Description"
		prize.user_id 1
	end

	factory :house do |house|
		house.name "Sample House"
	end

	factory :location do |location|
		location.street_type "Rua"
		location.street_name "Tatajuba"
		location.street_number "50"
		location.latitude 0
		location.longitude 0
	end

	factory :neighborhood do |n|
		n.name "Mare"
	end
end