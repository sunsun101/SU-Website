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

When('I visit the admin page') do
  visit '/admin/users'
  # save_and_open_page
end

Then('I should see a list of registered users') do
  expect(page).to have_css('table', text: @user.email)
end

Then('I should see user statistics') do
  # save_and_open_page
  expect(page).to have_css('#curve_chart')
end

And('I should see a link to ban user') do
  expect(page).to have_link('Ban', href: '/admin/users?user_ban=' + @user.id.to_s)
end

When('I click the link to ban the user') do
  find_link('Ban', href: '/admin/users?user_ban=' + @user.id.to_s).click
end

Then('I should see that the user is banned') do
  # save_and_open_page
  tr = find('tr', text: @user.email)
  expect(tr).to have_content('Banned')
end

And('I should see a link to un-ban user') do
  expect(page).to have_link('Ban', href: '/admin/users?user_unban=' + @user.id.to_s)
end

When('I click the link to un-ban the user') do
  find_link('Ban', href: '/admin/users?user_unban=' + @user.id.to_s).click
end

Then('I should see that the user is active') do
  # save_and_open_page
  tr = find('tr', text: @user.email)
  expect(tr).to have_content('Active')
end
