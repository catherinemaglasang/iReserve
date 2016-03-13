Feature: Sign Up
		Creating an account


	Scenario: Signing up with complete information
    Given I have input the needed information as follows:
    | email address | password | first name | surname | contact number | address | postal code | gender | birthdate |
    | yan01@gmail.com | demeter3616 | yan | corpuz | 0906 | lugait | 900 | F | 11/10/96 | 
    When I click the done button 
    Then the information is saved in the database