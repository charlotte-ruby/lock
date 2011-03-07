#Hackety hack.. this file will not work well with autotest, since it relies on previous steps.  
#TODO: I need to figure out how to do this without such a hack.  Tricky b/c the controllers need to reload before the scenario starts

Feature: Lock
  In order to use lock
  As a user
  I want to be able to login and unlock pages

  Scenario: User can see everything if lock is not specified
    Given application controller blank
    Given I am on the widgets page
    Then I should see "widgets index"
    Given I am on the new widget page
    Then I should see "new widget"
    Given I am on the wadgets page
    Then I should see "wadgets index"
    Given I am on the new wadget page
    Then I should see "new wadget"   

  Scenario: All actions should
    Given application controller lock setup
    Given I am on the widgets page
    Then I should see "This page is locked"
    Given I am on the new widget page
    Then I should see "This page is locked"
    Given I am on the wadgets page
    Then I should see "This page is locked"
    Given I am on the new wadget page
    Then I should see "This page is locked"

  Scenario: All actions under the widgets controller should be locked, and wadgets should not be
    Given application controller lock controller setup
    Given I am on the widgets page
    Then I should see "This page is locked"
    Given I am on the new widget page
    Then I should see "This page is locked"
    Given I am on the wadgets page
    Then I should see "wadgets index"
    Given I am on the new wadget page
    Then I should see "new wadget"

  Scenario: single action should be locked for widgets
    Given application controller lock single action setup
    Given I am on the widgets page
    Then I should see "widgets index"
    Given I am on the new widget page
    Then I should see "This page is locked"
    Given I am on the wadgets page
    Then I should see "wadgets index"
    Given I am on the new wadget page
    Then I should see "new wadget"

  Scenario: single action should be locked one widget and one wadget action
    Given application controller lock multiple action setup
    Given I am on the widgets page
    Then I should see "widgets index"
    Given I am on the new widget page
    Then I should see "This page is locked"
    Given I am on the wadgets page
    Then I should see "This page is locked"
    Given I am on the new wadget page
    Then I should see "new wadget"

  Scenario: All widget actions are locked and one wadget action is locked
    Given application controller lock mixed setup
    Given I am on the widgets page
    Then I should see "This page is locked"
    Given I am on the new widget page
    Then I should see "This page is locked"
    Given I am on the wadgets page
    Then I should see "This page is locked"
    Given I am on the new wadget page
    Then I should see "new wadget"

  Scenario: User can login and see all pages
    Given application controller lock setup
    Given I am on the lock login page
    And I fill in "password" with "mypassword"
    And I press "Unlock"
    Then I should see "Unlocked!"
    Given I am on the widgets page
    Then I should see "widgets index"
    Given I am on the new widget page
    Then I should see "new widget"
    Given I am on the wadgets page
    Then I should see "wadgets index"
    Given I am on the new wadget page
    Then I should see "new wadget"

  Scenario: User enters wrong password
    Given I am on the lock login page
    And I fill in "password" with "mypassword2"
    And I press "Unlock"
    Then I should be on the lock login page