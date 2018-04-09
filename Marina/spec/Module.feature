Feature: MarinaModule object behaviour

  Scenario: Creating a blank module
    Given a blank MarinaConfiguration object
    And a test module directory
    When Add-MarinaModule is called with test parameters
    Then a MarinaModule object is returned
    And the number of Modules is 1
    