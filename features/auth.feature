Feature: log in to ReportDengue

  As a user
  I want to be able to log in to my account
  So that I can view all ReportDengue activity

Background: users in database

  Given the following users exist:
	|	id	|	username 		|	password_digest													|	auth_token				|	email			|
	|	1	|	LukeSkywalker	|	$2a$10$FHxQA0YGyRyoXBmwMawWEObx45AB5ZxKcD/8fXOO8dnghrzthn9zG	|	_uEsTkHWkhrlSlxTNWmSQQ	|	foo1@foo.com	|

Scenario: log in with username and password
  When I go to the root url
  And  I fill in "username" with "LukeSkywalker"
  And  I fill in "password" with "asdf123"
  And  I press "login"
  Then I should be on LukeSkywalker's user page

Scenario: find movie with same director
  Given I am on the details page for "Star Wars"
  When  I follow "Find Movies With Same Director"
  Then  I should be on the Similar Movies page for "Star Wars"
  And   I should see "THX-1138"
  But   I should not see "Blade Runner"

Scenario: can't find similar movies if we don't know director (sad path)
  Given I am on the details page for "Alien"
  Then  I should not see "Ridley Scott"
  When  I follow "Find Movies With Same Director"
  Then  I should be on the home page
  And   I should see "'Alien' has no director info"