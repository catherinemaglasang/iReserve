Feature: Verification

  Scenario: Verification
	Given I am the system administrator
	And I am in the dashboard
	When I verify or reject accounts
	Then the account is either verified or rejected