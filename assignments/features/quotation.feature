Feature: Quotation

Scenario: Add quotations to a project
    A user should be able to add quotations to a project.
    
    Given I want to add a quotation to the project
    When I hide the quotations
    Then I should add quotation id to cookie
    When I click restore
    Then I should see all existing quotations