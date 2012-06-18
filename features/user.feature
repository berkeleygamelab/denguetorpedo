Feature: log in to ReportDengue

  As a user
  I want to be able to log in to my account
  So that I can view all ReportDengue activity

Background: users in database

  Given the following users exist:
	|	id	|	username   		|	password		|	auth_token	      			|	email			    |
	|	1  	|	LukeSkywalker	|	secret			|	_uEsTkHWkhrlSlxTNWmSQQ	|	foo1@foo.com	|

  And the following neighborhoods exist:
	|	id	|	name   		|	coordinator_id	|
	|	1 	|	Elmwood		|	1       				|
	
	
Scenario: login (happy path)
  When  I go to the root url
  And   I fill in "username" with "LukeSkywalker"
  And   I fill in "password" with "secret"
  And   I press "Login"
  Then  I should be on the root url
  And   I should see "Welcome! LukeSkywalker"
  But   I should not see "Invalid username or password."

Scenario: login (sad path)
  When  I go to the root url
  And   I fill in "username" with "LukeSkywalker"
  And   I fill in "password" with "badpassword"
  And   I press "Login"
  Then  I should be on the root url
  And   I should see "Invalid username or password."
  But   I should not see "Welcome! LukeSkywalker"

Scenario: logout (happy path)
  Given I am logged in as "LukeSkywalker" with password "secret"
  When  I go to the root url
  And   I follow "Logout"
  Then  I should be on the root url
  And   I should see "Remember me"
  And   I should see "Forgot password?"
  And   I should see "Register"
  But   I should not see "Welcome! LukeSkywalker"
  And   I should not see "Logout"

Scenario: register (happy path)
  When  I go to the root url
  And   I fill in "phone" with "1234567890"
  And   I fill in "email" with "test@reportdengue.com"
  And   I fill in "username" with "TestUser1"
  And   I fill in "password" with "asdf123"
  And   I fill in "password" with "asdf123"
  And   I press "Finish"
  Then  I should be on the TestUser1's edit user page
