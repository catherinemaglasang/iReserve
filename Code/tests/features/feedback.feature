Feature: A feature that allow guest to give and view feedback to a hotel
  and admin to delete a feedback

    As a website guest, I want to be able to give feedback
    and view feedback
    As a admin, I want to be able to delete specific feedback

  Scenario: Give Feedback(Sunny)
    Given I am in the hotel feedback form with details:
          | name | comment | hotel_id |
          | Neiell | Try | 1 |
    When I submit the feedback form
    Then I should get a '200' response
    And a message 'Feedback Created' are returned

  Scenario: Give Feedback(Rainy)
    Given I am in the hotel feedback form with details:
          | name | comment | hotel_id |
          | Neiell |  | 1 |
    When I submit the feedback form
    Then I should get a '200' response
    And a message 'error' are returned


  Scenario: View Feedback
    Given I am in the hotel's page with id:
        | hotel_id |
        |    1     |
    When I pressed view all feedback
    Then I should get a '200' response
    And it returns all hotel's feedback:
        | comment | created_date | id | name |
        | hahaha | Thu, 17 Mar 2016 18:01:24 GMT | 1 | koneb |


