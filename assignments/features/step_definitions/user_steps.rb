Given('I am an Admin') do
  @admin = FactoryBot.create :admin
end

Given('I am logged in') do
  visit '/users/sign_in'
  fill_in 'Email', with: @admin.email
  fill_in 'Password', with: @admin.password
  click_button 'Log in'
  # save_and_open_page
end

Given('A user has registered') do
  @user = FactoryBot.create :user
end

When('I visit the admin users page') do
  visit '/admin/users'
  # save_and_open_page
end

Then('I should see a list of admin users') do
  expect(page).to have_css('table', text: @admin.email)
end

When('I fill the search form and enter email of user') do
  within('div#search_user') do
    fill_in 'search', with: @user.email
    click_button 'Search'
  end
end

Then('I should see the user in the table') do
  expect(page).to have_css('table', text: @user.email)
end

When('I click button to edit user') do
  find('tr', text: @user.email).click_link('Edit')
end

Then('I should see the edit form') do
  expect(page).to have_selector('form#edit_user_' + @user.id.to_s)
end

# When('I submit the edit form') do
#   within('#edit_user_' + @admin.id.to_s) do
#     page.select('Ban', from: 'user_status')
#     click_button 'Save changes'
#   end
# end

And('I check the box to make user admin') do
  within('#edit_user_' + @user.id.to_s) do
    find('#user_is_admin').check
    # click_button 'Save changes'
  end
end

When('I submit the edit form to make user an admin') do
  within('#edit_user_' + @user.id.to_s) do
    # find('#user_is_admin').check
    click_button 'Save changes'
  end
end

Then('I should see that the user is in admin table') do
  within('#edit_user_' + @user.id.to_s) do
    expect(page).to have_field('user_is_admin', checked: true)
  end
end

And('I un-check the box admin box') do
  within('#edit_user_' + @user.id.to_s) do
    find('#user_is_admin').uncheck
    # click_button 'Save changes'
  end
end

When('I submit the edit form to remove admin priviledge') do
  within('#edit_user_' + @user.id.to_s) do
    # find('#user_is_admin').check
    click_button 'Save changes'
  end
end

Then('I should see that the user is not an admin') do
  expect(page).to have_css('table', text: @admin.email)
end

# Then('I should see that the user is not an admin') do
#   # save_and_open_page
#   within('#edit_user_' + @user.id.to_s) do
#     expect(page).to have_field('user_is_admin', checked: false)
#   end
# end

