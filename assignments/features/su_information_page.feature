Feature: SU Information Page

Scenario: Create Member
    Admin user should be able to create SU Members.
    
    Given I am an Admin
    And I am logged in
    Given I want to create a SU Member 
    Then I should see link to the SU Information Page
    When I click the link to the SU Information Page
    Then I should see a button to add member
    When I click the button to add member
    Then I should see a form to create user
    When I submit the user creation form
    Then I should see new member added