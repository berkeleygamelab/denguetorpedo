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