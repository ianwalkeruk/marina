Feature: MarinaConfiguration object behaviour
  The configuration management of multiple containers
  can be described using a MarinaConfiguration object

  Scenario: Creating a blank configuration
    When New-MarinaConfiguration is called with no parameters
    Then a MarinaConfiguration object is returned
    