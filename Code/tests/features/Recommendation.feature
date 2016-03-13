Feature: Recommendation

  Scenario: Recommendation
	Given the hotel is registered on the website
	When the system records the number of times the hotel is visited
	And the hotels are ranked according to the number of times it was visited
	Then the top five hotels will be displayed on the sidebar of the website