Feature: Verification

  Scenario: Verification
	Given I am in the dashboard
	When I verify or reject accounts
	Then the account is either verified or rejected