Feature: Events 

Scenario: Create Event
    An admin user should be able to create events
    
    Given I am an Admin
    Given I want to create an event
    And I am logged in
    Then I should see link to create event  
    When I click the link to create event
    Then I should see a form to create event
    When I submit the event form
    Then I should see the created event
  

Scenario: Edit Event

    Given I am an Admin
    Given There is an event
    And I am logged in
    When I visit events page
    And I click the event
    Then I should see an edit button
    When I click the edit button
    Then I should see the edit form
    When I submit the event edit form 
    Then I should see the changes in the event

Scenario: Delete Event

    Given I am an Admin
    Given There is an event
    And I am logged in
    When I visit events page
    And I click the event
    Then I should see a delete button
    When I click the delete button
    Then I should get an alert
    Then I should see that the event has been deleted

Scenario: Filter Events
    Given There are events
    When I visit events page
    When I select category
    Then I should see filtered events

    