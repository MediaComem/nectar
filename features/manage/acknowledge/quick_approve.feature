Feature: Quick Approve orders

  In order to approve contracts quickly
  As a Lending Manager
  I want to have quick approve functionalities on the submitted orders

  Background:
    Given I am Pius

  Scenario: Quick approve an order with no problems
    Given I navigate to the open orders
    When I quick approve a submitted order
    Then this order is approved
    And I see a link to the hand over process of that order

  Scenario: Approve anyway on daily view
    Given I navigate to the open orders
    And I scroll to the bottom of the page
    And I try to approve a contract that has problems
    Then I got an information that this contract has problems
    When I approve anyway
    Then this order is approved

