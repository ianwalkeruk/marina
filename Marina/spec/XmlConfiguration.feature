Feature: A configuration can be imported and exported as XML

Scenario: Importing a correctly-formatted configuration
  Given we have a correctly-formatted configuration file
  When we call Import-MarinaConfiguration
  Then the configuration loads successfully
