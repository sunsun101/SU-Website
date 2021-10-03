Given('I have a quotation') do
  @quotation = FactoryBot.build :quotation
end

Given('I visit the problem set two  page') do
  visit root_url
end

Then('I should see a link for the ps two') do
  expect(page).to have_link('Quotations', href: basics_quotations_path())
end

When('I click the link for the ps two') do
  find_link('Quotations', href: basics_quotations_path()).click()
end

Then('I should see a form to add quotations') do
  expect(page).to have_selector('form#new_quotation')
  p @quotation
end

When('I submit the form') do
  fill_in 'Author name', with: @quotation.author_name
  fill_in 'New Category', with: @quotation.category
  fill_in 'Quote', with: @quotation.quote
  click_button 'Create'
end

Then('I should see the added quotations') do
 expect(page).to have_content "#{@quotation.author_name}"
 expect(page).to have_content "#{@quotation.quote}"
end

# When('I click the delete') do
#   find_link('delete', href: basics_quotations_path()+'?quotation_id='+@quotation.id.to_s).click()
#   p @quotation
# end

Then('I should see restore option') do
  expect(page).to have_link("Restore", @href=basics_quotations_path())
end

When('I click the restore') do
  find_link('Restore', href: basics_quotations_path()).click()
end

Then('I should see the quotations') do
  expect(page).to have_content "#{@quotation.author_name}"
  expect(page).to have_content "#{@quotation.quote}"
end