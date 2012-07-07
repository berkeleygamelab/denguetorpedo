# Add a declarative step here for populating the DB with users

Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that user to the database here.
    u = User.new(user)
    u.house_id = user['house_id'] if user['house_id']
    u.save
  end

end

Given /^I am logged in as "([^\"]*)" with password "([^\"]*)"$/ do |username, password|
  visit root_url
  fill_in "username", :with => username
  fill_in "password", :with => password
  click_button "Log In"
end

