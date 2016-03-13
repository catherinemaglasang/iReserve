Feature: Handle storing, retrieving details

  Scenario: Retrieve a hotel's details
    Given some hotels are in the system
    When I retrieve the hotel '1'
    Then I should get a '200' response
    And the following hotel details are returned:
    | hotel_id | hotel_name | description | email_address | address | contact_number | google_map | no_of_restaurant | no_of_rooms | extra | is_active |
    | 1 | luxury | blablabla | blabla@gmail.com | iligan | 09061112441 | map | 2 | 50 | 5 | true |