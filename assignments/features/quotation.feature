Feature: Quotation

Scenario: Manipulate quotations to a project
    A user should be able to add and delete quotations to a project.
    
    Given I have a quotation
    Given I visit the problem set two  page
    Then I should see a link for the ps two
    When I click the link for the ps two
    Then I should see a form to add quotations
    When I submit the form 
    Then I should see the added quotations
    Then I should see restore option
    When I click the restore
    Then I should see the quotations