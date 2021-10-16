Feature: Admin tasks

Scenario: Manage users
    A User Admin should be able to view and ban registered users.
    
    Given I am an Admin
    And I am logged in
    And A user has registered   
    When I visit the admin page
    Then I should see a list of registered users
    # And I should see user statistics
    And I should see a link to ban user
    When I click the link to ban the user
    Then I should see that the user is banned
    And I should see a link to un-ban user
    When I click the link to un-ban the user
    Then I should see that the user is active