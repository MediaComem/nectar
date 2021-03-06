
Feature: Templates

  Background:
    Given I am Normin

  @rack
  Scenario: Finding the list of templates in the borrow section
    Given I am listing the main categories
    Then I see a link to the templates underneath the categories

  @rack
  Scenario: List of templates
    When I am listing templates in the borrow section
    Then I see the templates
    And the templates are sorted alphabetically by name
    And I can look at one of the templates in detail

  Scenario: Viewing a template in the borrow section
    Given I am looking at a template
    Then I see all models that template contains
    And the models in that template are ordered alphabetically
    And for each model I see the quantity as specified by the template
    And I can modify the quantity of each model before ordering
    And I can specify at most the maximum available quantity per model
    And I have to continue the process of specifying start and end dates

  @rack
  Scenario: Warning when looking at uncompletable templates
    Given I am looking at a template
    And this template contains models that don't have enough items to satisfy the quantity required by the template
    Then I see a warning on the page itself and on every affected model

  Scenario: Entering a date after entering a quantity
    Given I have chosen the quantities mentioned in the template
    Then the start date is today and the end date is tomorrow
    And I can change the start and end date of a potential order
    And I have to follow the process to the availability display of the template
    And all entries get the chosen start and end date

  Scenario: Availability display of a template
    Given I am looking at a template
    And I am looking at the availability of a template that contains unavailable models
    Then those models are highlighted that are no longer available at this time
    And the models are sorted alphabetically within a group
    And I can remove the models from the view
    And I can change the quantity of the models
    And I can change the time range for the availability calculatin of particular models
    When I have solved all availability problems
    Then I can continue in the process and add all models to the order at once

  Scenario: Only ordering those models from a template that are available
    Given I see the availability of a template that has items that are not available
    Then I can follow the process to the availability display of the template
      And I can follow the process to the availability display of the template
      And I can follow the process to the availability display of the template
      And the template was added to my order
