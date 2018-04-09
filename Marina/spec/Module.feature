Feature: MarinaModule object behaviour
 The configuration management of an installable module
 can be described using a MarinaModule object

  Scenario: Creating a blank module
    Given a blank MarinaConfiguration object
    And a test module directory
    When Add-MarinaModule is called with test parameters
    Then a MarinaModule object is returned
    And the number of Modules is 1
  
  Scenario: Creating two blank modules
    Given a blank MarinaConfiguration object
    And a test module directory
    And an alternate test module directory
    When Add-MarinaModule is called with test parameters
    And Add-MarinaModule is called with alternate test parameters
    Then the number of Modules is 2