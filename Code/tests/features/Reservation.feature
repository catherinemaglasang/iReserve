Feature: Reservation

  Scenario: Add Reservation
	Given I am the customer
	And I am logged on to the website
	And I am on the hotel’s profile
	When I click the “Reserve” button

  Scenario: Reservation History (Hotel)
	Given I am the reservation personnel/customer
	And I am in the hotel’s profile page
	When I click the “reservation history” button
	Then a list of anonymous people who reserved the hotel is displayed


  Scenario: Reservation History (Customer)
	Given I am the customer
	And I am in my profile page
	When I click the “Reservation history” button
	Then a list of my past reservations will be displayed