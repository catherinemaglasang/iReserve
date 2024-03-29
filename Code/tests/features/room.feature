Feature: Adding, Updating, and Retrieving room details


Scenario: Adding a new room 
		Given I input the following room details:
		| room_number | cost | room_type | hotel_id | 
	    | 120 | 3000 | one-bed | 1 | 
        When I click the add button
        Then the room is added in the system
        And it should have a field "message" containing "OK"
        And it should have a field "status" containing "ok"

	
Scenario: Adding a room that already exist
		Given I input the following room details:
		| room_number | cost | room_type | hotel_id | 
	    | 300 | 4500 | one-bed | 1 | 
	    When I click the add button
	    Then i should get a "message" containing "ID EXISTED"

Scenario: Adding a room that has the field room_number empty
		Given I input the following room details:
		| room_number | cost | room_type | hotel_id | 
	    | | 4500 | one-bed | 1 | 
	    When i click the add button
	    Then i should '200' response 
	    And a message "error" are returned

Scenario: Adding a room that has the field room_type empty
		Given I input the following room details:
		| room_number | cost | room_type | hotel_id | 
	    | 400 | 4500 | | 1 | 
	    When i click the add button
	    Then i should '200' response 
	    And a message "error" are returned

Scenario: Adding a room that has the field room_number and room_type empty
		Given I input the following room details:
		| room_number | cost | room_type | hotel_id | 
	    |  | 4500 | | 1 | 
	    When i click the add button
	    Then i should '200' response 
	    And a message "error" are returned


Scenario: Retrieve room's details
		Given a room exist with an id number "1"
		When I retrieve the room with an id number '1'
		Then I should get a '200' response
		And the following details are returned:
		| room_number | cost | room_type |
	    | 300 | 4500 | one-bed |

Scenario: Retrieve a non-existent room
		Given a room with an id number "5" doesnt exist
		When i retrieve a room with an id number '5'
		Then it should have a field "status" containing "error"
		And it should have a field "message" containing "Results Not Found"


Scenario: Update room details 
		Given a room with an id number "3" with the following details:
		| room_number | cost | room_type |
	    | 200 | 6000 | Luxury |
	    When i update the room details into the following:
	    | room_number | cost | room_type |
	    | 200 | 6000 | twin-bed |
	    Then i will get a '200' response
	    And it should have a field "status" containing "success"

