# Given('I am a Admin') do
#   @admin = FactoryBot.create :admin
# end

# Given('I am logged in') do
#   visit '/'
#   click_link 'Log in'
#   fill_in 'Email', with: @admin.email
#   fill_in 'Password', with: @admin.password
#   click_button 'Log in'
#   # save_and_open_page
# end

# Given('Two new users have registered') do
#   @user1 = FactoryBot.create :user1
#   @user2 = FactoryBot.create :user2
# end

# When('I visit Administration page') do
#   visit '/administration'
#   # save_and_open_page
# end

# Then('I should see registered users') do
#   expect(page).to have_css('table', text: @admin.email)
#   expect(page).to have_css('table', text: @user1.email)
#   expect(page).to have_css('table', text: @user2.email)
# end

# Then('I should see user statistics') do
#   # save_and_open_page
#   expect(page).to have_css('#chart-1')
# end

# When('I ban a user') do
#   find('tr', text: @user2.email).click_link('Edit')
#   find(:css, '#user_status').find(:option, 'Banned').select_option
#   click_button 'Save' # this line causes warning in console "warning: Using the last argument as keyword parameters is deprecated;",
#   visit '/administration' # TODO:  find what causes the warning
# end

# Then('I should see that user is banned') do
#   # save_and_open_page
#   tr = find('tr', text: @user2.email)
#   expect(tr).to have_content('Banned')
# end
