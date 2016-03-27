Feature: A feature that allow customer to search hotel using keyword/s

    As a customer, I want to be able to search hotel using keyword/s

  Scenario: Search
    Given I filled up search box with keyword 'cagayan'
    When I submit the keyword
    Then I should get a '200' response
    And it should return this following hotel with its detail:
      | id_hotel | hotel_name | description | email_address | address | contact_number | no_of_restaurant | no_of_rooms | extra |
      | 1 | kingsway | inn | kingsway@iligan.com | cagayan de oro city | 023    | 0 | 30 | hali na! |