Feature: Lock
  In order to use lock
  As a user
  I want to be able to login and unlock pages

  Scenario: User can't see locked pages if they dont enter the password
    Given application controller lock setup
    Given I am on the widgets page
    Then I should see "This page is locked"
    Given I am on the new widget page
    Then I should see "This page is locked"
    Given I am on the wadgets page
    Then I should see "This page is locked"
    Given I am on the new wadget page
    Then I should see "This page is locked"

  Scenario: User enters password and can see all pages
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

  Scenario: User enters wrong password, they should be redirected
    Given I am on the lock login page
    And I fill in "password" with "mypassword2"
    And I press "Unlock"
    Then I should be on the lock login page