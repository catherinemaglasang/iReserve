Feature: Messaging

  Scenario: Messaging
	Given I am already logged on
	When I send a message to the reservation personnel
	Then the Reservation Personnel will be able to see the message
	And he/she will be able to reply to it