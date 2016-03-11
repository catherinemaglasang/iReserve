 Feature: Logout

 Scenario: Logout
	Given I am currently logged in
	When I click the “Logout” button
	Then I will be redirected to the login page