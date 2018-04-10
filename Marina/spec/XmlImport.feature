Feature:  import and export of configurations
 A configuration can be imported and exported
 as an XML file by default

Scenario: Importing a correctly-formatted configuration, default format
  Given we have a correctly-formatted XML configuration file
  When we call Import-MarinaConfiguration -FileName
  Then the configuration loads successfully

Scenario: Importing a correctly-formatted configuration, XML format
  Given we have a correctly-formatted XML configuration file
  When we call Import-MarinaConfiguration -FileName -Xml
  Then the configuration loads successfully
