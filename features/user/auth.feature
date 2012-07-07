Feature: log in to ReportDengue

  As a user
  I want to be able to log in to my account
  So that I can view all ReportDengue activity

Background: users in database

  Given the following users exist:
	|	id	|	username   		|	password		|	auth_token	      			|	email			    |
	|	1  	|	LukeSkywalker	|	secret			|	_uEsTkHWkhrlSlxTNWmSQQ	|	foo1@foo.com	|

	
Scenario: login (happy path)
  When  I go to the root url
  And   I fill in "username" with "LukeSkywalker"
  And   I fill in "password" with "secret"
  And   I press "Log In"
  Then  I should be on the root url
  And   I should see "Welcome! LukeSkywalker"
  But   I should not see "Invalid username or password."

Scenario: login (sad path)
  When  I go to the root url
  And   I fill in "username" with "LukeSkywalker"
  And   I fill in "password" with "badpassword"
  And   I press "Log In"
  Then  I should be on the root url
  And   I should see "Invalid username or password."
  But   I should not see "Welcome! LukeSkywalker"

Scenario: logout (happy path)
  Given I am logged in as "LukeSkywalker" with password "secret"
  When  I go to the root url
  And   I follow "Logout"
  Then  I should be on the root url
  And   I should see "Register"
  But   I should not see "Welcome! LukeSkywalker"
  And   I should not see "Logout"

Scenario: register (happy path)
  When  I go to the root url
  And   I fill in "user[phone_number]" with "1234567890"
  And   I fill in "user[email]" with "test@reportdengue.com"
  And   I fill in "user[username]" with "TestUser1"
  And   I fill in "user[password]" with "asdf123"
  And   I fill in "user[password_confirmation]" with "asdf123"
  And   I press "Finish"
  Then  I should be on TestUser1's edit user page

Scenario: register (sad path, no password)
  When  I go to the root url
  And   I fill in "user[phone_number]" with "1234567890"
  And   I fill in "user[email]" with "test@reportdengue.com"
  And   I fill in "user[username]" with "TestUser1"
  And   I fill in "user[password]" with ""
  And   I fill in "user[password_confirmation]" with ""
  And   I press "Finish"
  Then  I should be on the registration failure page
  And   I should see "Password digest can't be blank"

Scenario: register (sad path, passwords do not match)
  When  I go to the root url
  And   I fill in "user[phone_number]" with "1234567890"
  And   I fill in "user[email]" with "test@reportdengue.com"
  And   I fill in "user[username]" with "TestUser1"
  And   I fill in "user[password]" with "asdf123"
  And   I fill in "user[password_confirmation]" with "asdf45"
  And   I press "Finish"
  Then  I should be on the registration failure page
  And   I should see "Password doesn't match confirmation"

Scenario: register (sad path, username taken)
  When  I go to the root url
  And   I fill in "user[phone_number]" with "1234567890"
  And   I fill in "user[email]" with "test@reportdengue.com"
  And   I fill in "user[username]" with "LukeSkywalker"
  And   I fill in "user[password]" with "asdf123"
  And   I fill in "user[password_confirmation]" with "asdf123"
  And   I press "Finish"
  Then  I should be on the registration failure page
  And   I should see "Username has already been taken"

Scenario: register (sad path, username not provided)
  When  I go to the root url
  And   I fill in "user[phone_number]" with "1234567890"
  And   I fill in "user[email]" with "test@reportdengue.com"
  And   I fill in "user[username]" with ""
  And   I fill in "user[password]" with "asdf123"
  And   I fill in "user[password_confirmation]" with "asdf123"
  And   I press "Finish"
  Then  I should be on the registration failure page
  And   I should see "Username should only contain letters, numbers, or .-+_@, and have between 5-15 characters"
