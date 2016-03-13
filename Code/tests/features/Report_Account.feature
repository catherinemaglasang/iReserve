Feature: Report Account

  Scenario: Report Account
    Given I am in the hotel/customer’s profile page
    When I click the “Report” button
    Then a message will pop-up “Account Reported”
    And the System Administrator receives a notification on reported accounts