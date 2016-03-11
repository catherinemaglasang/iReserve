Feature: Profile

  Scenario: Customer’s Profile
    Given I am already logged in
    When I click the “View Profile” button
    Then I will be redirected to my profile page
    And I will be able to view my profile informations

  Scenario: Hotel’s Profile
	Given I am already logged in
	When I click the “View Hotel” button
	Then I will be redirected to the hotel’s profile page
	And I will be able to view the hotel’s profile informations

  Scenario: Update Profile
	Given I am logged on the website
	And I am in my profile page
	When I update my profile information
	And clicks the “Submit” button
	Then the updated information is reflected on my profile page