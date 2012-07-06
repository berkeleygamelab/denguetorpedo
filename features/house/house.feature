Feature: click through links in a house page

  As a user
  I want to be able to access the house page
  So that I can view all links with no errors in a house page

Background: users, neighborhoods, locations, houses in database

	Given the following neighborhoods exist:
	|	id	|	name   		|	coordinator_id	|
	|	1 	|	Elmwood		|	1       				|

	Given the following locations exist:
	|	id	| address					| neighborhood_id	 |
	|	1 	| 2521 Regent St 	|	1					  		 |

	Given the following houses exist:
	|	id	|	name      | location_id      |
	|	1 	|	Tatooine  | 1                |

  Given the following users exist:
	|	id	|	username   		|	password		|	auth_token	      			|	email			    |  house_id |
	|	1  	|	LukeSkywalker	|	secret			|	_uEsTkHWkhrlSlxTNWmSQQ	|	foo1@foo.com	|  1				|
	|	2  	|	NoobSkywalker	|	secret			|	_uEsTkHWkhrlSlxTNWmSQQ	|	foo2@foo.com	|  1				|
	|	3  	|	ProSkywalker	|	secret			|	_uEsTkHWkhrlSlxTNWmSQQ	|	foo3@foo.com	|  1				|


Scenario: access a house page after logging in
	When  I go to the root url
	And   I fill in "username" with "LukeSkywalker"
	And   I fill in "password" with "secret"
	And   I press "Log In"
  Then  I should be on the root url
  And   I should see "Welcome! LukeSkywalker"
  When  I follow "My House"
  Then  I should be on the house page for "LukeSkywalker"
  And   I should see "Tatooine"
  And   I should see "Neighborhood"
  And   I should see "Elmwood"
  And   I should see "House Badges"
  And   I should see "Write a Blog about Dengue..."
  And   I should see "What's happening?"

Scenario: access a house page without logging in
	When  I go to the "Tatooine" house page
  Then  I should see "Tatooine"
  And   I should see "Neighborhood"
  And   I should see "Elmwood"
  And   I should see "House Memebers"
  And   I should see "Write a Blog about Dengue..."
  And   I should see "What's happening?"
  And   I should see "LukeSkywalker"
  And   I should see "NoobSkywalker"
  And   I should see "ProSkywalker"
  But   I should not see "My Profile"
  When  I follow "NoobSkywalker"
  Then  I should be on NoobSkywalker's user page
  