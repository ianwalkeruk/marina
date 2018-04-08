Feature: MarinaModule object behaviour

  Scenario: Creating a blank module
    Given a blank MarinaConfiguration object
    When Add-MarinaModule is called with no parameters
    Then a MarinaModule object is returned
    And the number of Modules is 1
    