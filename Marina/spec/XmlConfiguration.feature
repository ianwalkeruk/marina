Feature: A configuration can be imported and exported as XML

Scenario: Importing a correctly-formatted configuration, implied XML
  Given we have a correctly-formatted XML configuration file
  When we call Import-MarinaConfiguration -FileName
  Then the configuration loads successfully

Scenario: Importing a correctly-formatted configuration, forced XML
  Given we have a correctly-formatted XML configuration file
  When we call Import-MarinaConfiguration -FileName -Xml
  Then the configuration loads successfully
