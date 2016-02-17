Feature: Notification

  Scenario: Notification (Reservation Personnel)
	Given I am the reservation personnel
	And I am logged on the website
	When a customer avail a reservation
	Then I will be able to receive a notification
    And I can choose whether to accept or to decline it

  Scenario: Notification (Customer)
	Given I am the customer
	And I am logged on the website
	When I avail a reservation
	Then I will receive a notification whether the Reservation personnel declined or accepted my request