Feature: MarinaImageSet object behaviour
 The dependencies and installation state of some Modules
 can be described by an ImageSet object

  Scenario: Adding a test image set
    Given a blank MarinaConfiguration object
    When Add-MarinaImageSet is called with test parameters
    Then a MarinaImageSet object is returned
    And the number of ImageSets is 1
