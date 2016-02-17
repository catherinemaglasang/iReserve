Feature: Feedback

  Scenario: Feedback
	Given I am the customer
	And I am already logged in
	And I am on the reservation personnel’s profile
	When I input my comment in the text area
	And I press “Submit” button
	Then my feedback will be posted on the page
	And the reservation personnel will be able to see it