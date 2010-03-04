Feature: Browse features over the web
  As a Cucumber user
  I want to browse my feature files in my web browser
  
  Scenario: See a list of features
    When I visit "/"
    Then I should see "features/web_interface.feature"
    Then I should not see "/features"
  
  Scenario: Read a feature file
    When I visit "/"
    And I follow "features/web_interface.feature"
    Then I should see
    """
    Feature: Browser features over the web
      As a Cucumber user
      I want to browse my feature files in my web browser
    """

