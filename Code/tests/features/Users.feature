Feature: Users

  Scenario: Login
    Given I am the customer/reservation personnel/system administrator
    When I enter the required fields
    And clicked the login button
    Then I will be logged in to the site
    And I can fully access the site

  Scenario: Sign Up
	Given I am the customer/reservation personnel
	And I haven’t signed up
	When I entered all the required fields
	And I clicked the sign up button
	Then I will have an account
	And I will be redirected to the login page

  Scenario: Logout
	Given I am the customer
	And I am currently logged in
	When I click the “Logout” button
	Then I will be redirected to the login page

  Scenario: Change Password
	Given I am the customer/system administrator
	And I am on my profile page
	When I click the “Change Password” button
	And I input a new password
	Then there will be a prompt saying “Password Successfully Changed”
