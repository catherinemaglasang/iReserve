Feature: Change Password

Scenario: Change Password
	Given I am on my profile page
	When I click the “Change Password” button
	And I input a new password
	Then there will be a prompt saying “Password Successfully Changed”
