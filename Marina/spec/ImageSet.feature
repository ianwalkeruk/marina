Feature: MarinaModule object behaviour

  Scenario: Creating a blank module
    Given a blank MarinaConfiguration object
    When Add-MarinaImageSet is called with test parameters
    Then a MarinaImageSet object is returned
    And the number of Modules is 1
    