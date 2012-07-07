# Add a declarative step here for populating the DB with houses

Given /the following houses exist/ do |houses_table|
  houses_table.hashes.each do |house|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that neighborhood to the database here.
    h = House.create!(house)
  end  
end
