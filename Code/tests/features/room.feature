Feature: Retrieve room's details

Scenario: Retrieve room's details
		Given some rooms are in the system
		When I retrieve the room with an id number '1'
		Then I should get a '200' response
		And the following room details are returned:
		| room_number | cost | room_type |
		| 209 | 2000 | one bed |

	

