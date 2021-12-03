Feature: Admin tasks

Scenario: Manage admin users

    A User Admin should be able to make users admins and also remove admin priviledge.
    
    Given I am an Admin
    And I am logged in
    And A user has registered   
    When I visit the admin users page
    Then I should see a list of admin users
    When I fill the search form and enter email of user
    Then I should see the user in the table
    When I click button to edit user
    Then I should see the edit form
    And I check the box to make user admin
    When I submit the edit form to make user an admin
    Then I should see that the user is in admin table
    When I click button to edit user
    Then I should see the edit form
    And I un-check the box admin box
    When I submit the edit form to remove admin priviledge
    Then I should see that the user is not an admin

Scenario: Manage admin committee
    A User Admin should be able to assign a committee to himself.
    
    Given I am an Admin
    And I am logged in
    And A user has registered   
    When I visit the admin users page
    Then I should see a list of registered admin users
    When I click button to edit user
    Then I should see form to edit user
    And I select committee
    When I submit the edit form
    Then I should see the assigned committee to the user

