Feature: Adding, Updating, and Retrieving room details


Scenario: Adding a new room 
		Given I input the following room details:
		| room_number | cost | room_type | hotel_id | 
	    | 120 | 3000 | one-bed | 1 | 
        When I click the add button
        Then the room is added in the system
        And it should have a field "message" containing "OK"
        And it should have a field "status" containing "ok"

	

