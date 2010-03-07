Feature: Browse features over the web
  As a Cucumber user
  I want to browse my feature files in my web browser
  
  @view_source
  Scenario: See a list of features
    When I visit "/"
    Then I should see "web_interface"
    And I should not see "/features"
    And I should not see ".feature"
  
  Scenario: Read a feature file
    When I visit "/"
    And I follow "web_interface"
    Then I should see
    """
    Feature: Browse features over the web
      As a Cucumber user
      I want to browse my feature files in my web browser
    """
  
  Scenario: View scenarios by tag
    When I view the "runnable_scenario" feature
    And I follow "@view_source"
    Then I should see
    """
    Feature: Runnable Scenario

      @view_source
      Scenario: Run a scenario
        When I do nothing

    Feature: Browse features over the web
      As a Cucumber user
      I want to browse my feature files in my web browser

      @view_source
      Scenario: See a list of features
        When I visit "/"
        Then I should see "web_interface"
        And I should not see "/features"
        And I should not see ".feature"
    """
  
  Scenario: View the source for a step
    When I view the "web_interface" feature
    And I follow "Then I should see "1 scenario (1 passed)""
    Then I should see
    """
    Then /^I should see$/ do |string|
      page.should have_content(string)
    end
    """
  
  Scenario: Run a scenario from the browser
    When I view the "runnable_scenario" feature
    And I follow "Run a scenario"
    Then I should see "1 scenario (1 passed)"
    And I should see "1 step (1 passed)"

