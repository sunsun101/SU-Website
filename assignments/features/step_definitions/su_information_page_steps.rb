Given('I want to create a SU Member') do
  @su_member = FactoryBot.build :su_member
  @tag = FactoryBot.create :committee
end

Then('I should see link to the SU Information Page') do
  expect(page).to have_link('SU Information', href: su_information_path)
end

When('I click the link to the SU Information Page') do
  find_link('SU Information', href: su_information_path).click
end

Then('I should see a link to add member') do
  expect(page).to have_link('Add Member')
end

When('I click the link to add SU member') do
  find_link('Add Member').click
end

Then('I should see a form to create user') do
  expect(page).to have_selector('form')
end

When('I submit the user creation form') do
  within('div#SUAddModal') do
    fill_in 'First Name', with: @su_member.first_name
    fill_in 'Last Name', with: @su_member.last_name
    fill_in 'Designation', with: @su_member.designation
    fill_in 'Nationality', with: @su_member.nationality
    page.select(@su_member.department, from: 'su_member_department')
    fill_in 'Program', with: @su_member.program
    page.select(@tag.name, from: 'su_member_tag_id')
    click_button 'Submit'
  end
end

# Then('I should see new member added') do
#   expect(page).to have_content @su_member.first_name
#   expect(page).to have_content @su_member.last_name
#   expect(page).to have_content @su_member.designation
#   expect(page).to have_content @su_member.nationality
#   expect(page).to have_content @su_member.department
#   expect(page).to have_content @su_member.program
# end
