Feature: Admin tasks

Scenario: Manage users
    A User Admin should be able to view and ban registered users.
    
    Given I am an Admin
    And I am logged in
    And A user has registered   
    When I visit the admin page
    Then I should see a list of registered users
    And I should see user statistics
    When I click button to edit user
    Then I should see form to edit user
    When I submit the edit form
    Then I should see that the user is banned
    When I click button to edit user
    Then I should see form to edit user
    When I submit the edit form to unban
    Then I should see that the user is active

Scenario: Manage admins

    A User Admin should be able to view and make users admins.
    
    Given I am an Admin
    And I am logged in
    And A user has registered   
    When I visit the admin page
    Then I should see a list of registered users
    When I click button to edit user
    Then I should see form to edit user
    When I submit the edit form to make user admin
    Then I should see that the user is admin
    When I click button to edit user
    Then I should see form to edit user
    When I submit the edit form to remove admin priviledge
    Then I should see that the user is not an admin