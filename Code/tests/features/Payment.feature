Feature: Online Payment

  Scenario: Online Payment
	Given I am the customer
	And had already logged in
	And I have a paypal account
	When I input my email and password
	And clicks “Send Payment”
	Then I will be directed to my paypal account
	And the room will be reserved to my name