Given(/^I want to add a quotation to the project$/) do
  @quotation = FactoryBot.create :quotation
end

Given(/^There is a form to add quotation$/) do
  visit 'basics/quotations'
  expect(page).to have_selector('form#new_quotation')
end

When(/^I submit the form$/) do
  fill_in 'Author name', with: @quotation.author_name
  fill_in 'New Category', with: @quotation.category
  fill_in 'Quote', with: @quotation.quote
  click_button 'Create'
end

Then(/^I should see the quote added to the quotations$/) do
  expect(page).to have_content @quotation.author_name
  expect(page).to have_content @quotation.category
  expect(page).to have_content @quotation.quote
end

Then(/^I should see a link to delete quote$/) do
  expect(page).to have_link('delete', href: '/basics/quotations?quotation_id=' + @quotation.id.to_s)
end

When(/^I click the link for delete quotation$/) do
  find_link('delete', href: '/basics/quotations?quotation_id=' + @quotation.id.to_s).click
end

Then(/^I should not see the quote$/) do
  expect(page).to have_content @quotation.author_name
  expect(page).to have_content @quotation.category
  expect(page).to have_content @quotation.quote
end

Then(/^I should see a link to restore quote$/) do
  expect(page).to have_link('Restore', href: '/basics/quotations?restore=')
end

When(/^I click the link for restore quotation$/) do
  find_link('Restore', href: '/basics/quotations?restore=').click
end

Then(/^I should see all existing quotations$/) do
  expect(page).to have_content @quotation.author_name
  expect(page).to have_content @quotation.category
  expect(page).to have_content @quotation.quote
end
