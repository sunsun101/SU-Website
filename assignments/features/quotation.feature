Feature: Quotation

Scenario: Manage Addition and user specific deletion of Quotations
    A user should be able to add quotations to a project.
    
    Given I want to add a quotation to the project
    Given There is a form to add quotation
    When I submit the form
    Then I should see the quote added to the quotations
    Then I should see a link to delete quote
    When I click the link for delete quotation
    Then I should not see the quote
    Then I should see a link to restore quote
    When I click the link for restore quotation
    Then I should see all existing quotations

    
