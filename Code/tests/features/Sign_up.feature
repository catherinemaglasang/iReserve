 Feature: Sign Up
  Creating an account

    Scenario: Signing up with correct information
    Given I have input the needed information
    When I click the done button
    Then the system will output a success message

    Scenario: Signing up using an existing email address
    Given I have input an existing email address
    When I click the done button
    Then the system will alert that the email address already exists

    Scenario:Signing up that lacks information
    Given I did not fill all the information needed
    When I click the done button
    Then the system will alert to input all the information needed
