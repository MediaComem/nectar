Feature: Sign Contract

  In order to hand things over and sign a contract
  As a lending manager
  I want to be able to hand selected things over and generate a contract

  Background:
    Given I am Pius

  Scenario: Hand over an not complete quantity of an option line
    Given there exists an approved option reservation for a normal user beginning today
    When I open the hand over page containing this reservation
    And I select an option line
    And I set the quantity for that option
    And I click hand over
    Then I see a summary of the things I selected for hand over
    And I see the quantity for this option
    And I fill in the purpose inside hand over dialog
    When I click hand over inside the dialog
    Then the quantity of options is handed over

  Scenario: Hand over reservations which start in the history
    When I open a hand over with overdue reservations
    And I select an overdue item line and assign an inventory code
    And I click hand over
    Then I see that the time range in the summary starts today
    When I click hand over inside the dialog
    Then the reservations start date is today

  Scenario: Hand over a selection of items
    When I open a hand over with models
    And I select an item line and assign an inventory code
    And I click hand over
    Then I see a summary of the things I selected for hand over
    When I click hand over inside the dialog
    Then the contract is signed for the selected items

  Scenario: Try to hand over unassigned items
    When I open a hand over with models
    # travel in time in case today is not an open day of the pool
    And today corresponds to the start date of the order
    # continue
    And I select an item without assigning an inventory code
    And I click hand over
    Then I got an error that i have to assign all selected item reservations

  Scenario: Model with accessories
    Given I open a hand over which has model which not all accessories are activated for this inventory pool
    Then I see only the active accessories for that model
    When I assign an inventory code to the item line
    And I click hand over
    When I click hand over inside the dialog
    Then the contract is signed for the selected items
    Then I see only the active accessories for that model within the contract
    When I open a take back for this user
    Then I see only the active accessories for that model

  Scenario: Add model with accessories
    Given I open a hand over which has model which not all accessories are activated for this inventory pool
    Then I see only the active accessories for that model
    When I assign an inventory code to the item line
    When I add the same model
    Then I see only the active accessories for that model
