# Add a declarative step here for populating the DB with locations

Given /the following locations exist/ do |locations_table|
  locations_table.hashes.each do |location|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that location to the database here.
    l = Location.find_or_create("2725 Haste St")
    l.neighborhood_id = location["neighborhood_id"]
    l.save
  end  
end