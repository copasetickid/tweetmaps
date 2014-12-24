Feature: User Login
  As a user
  I need a twitter account
  So I can access the application

  Scenario: User logins in via Twitter
    Given I am logged in via my twitter account
    And I am on my dashboard
    Then I should see my basic information
