Feature: Testing the sites login

  Scenario: Login with valid login
    Given I am not authenticated
    When I goto the login page
    And I enter valid confirmed credentials
    Then I am logged into the application

  Scenario: Login with an unconfirmed login
    Given I am not authenticated
    When I goto the login page
    And I enter valid unconfirmed credentials
    Then I see the unconfirmed message

  Scenario: Lost Password
  Scenario: Resend Confirmation
  Scenario: Resend Lockout

