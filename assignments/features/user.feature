Feature: Admin tasks

Scenario: As an admin I should be able to view registred users and ban certain users
    
    Given I am an Admin
    And I am logged in
    And A user has registered   
    When I visit the admin page
    Then I should see a list of registered users
    And I should see user statistics
    And I should see a button to ban the user
    When I click the button to ban the user
    Then I should see that the user is banned