Feature: A feature that will count page views

  Scenario: add page views
    Given I searched 'cagayan'
    When I view the Hotel page
    Then the hotel view will be incremented