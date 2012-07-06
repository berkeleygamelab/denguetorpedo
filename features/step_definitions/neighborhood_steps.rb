# Add a declarative step here for populating the DB with neighborhoods

Given /the following neighborhoods exist/ do |neighborhoods_table|
  neighborhoods_table.hashes.each do |neighborhood|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that neighborhood to the database here.
    n = Neighborhood.create!(neighborhood)
  end  
end