Given('I want to create an event') do
  @event = FactoryBot.build :event
end

Then("I should see link to create event") do
    expect(page).to have_link('Create Event', href: new_event_path())
end

When("I click the link to create event") do
  find_link('Create Event', href: new_event_path()).click
end

Then("I should see a form to create event") do
  expect(page).to have_selector('form#event_form')
end

When('I submit the event form') do
  fill_in 'Title', with: @event.title
  fill_in 'Description', with: @event.description
  fill_in 'Event date', with: @event.event_date
  # page.select('Accomodation', from: 'event_tag_id')
  click_button 'Submit'
end

Then("I should see the created event") do
  expect(page).to have_content @event.title
  expect(page).to have_content @event.description
  expect(page).to have_content @event.event_date.strftime("%b")
  expect(page).to have_content @event.event_date.strftime("%d")
end

Given('There is an event') do
  @tag = FactoryBot.create :tag
  @event = FactoryBot.create :event
end

When("I visit events page") do
  visit events_url
end

When('I click the event') do
  within('div.thumb') do
    find_link(href: event_path(@event)).click
  end
end

Then("I should see an edit button") do
  expect(page).to have_link('Edit', href: edit_event_path(@event))
end

When("I click the edit button") do
  find_link('Edit',href: edit_event_path(@event)).click
end

Then("I should see the event edit form") do
  expect(page).to have_selector('form#event_form')
end

When('I submit the event edit form') do
  fill_in 'Description', with: 'Changed Description'
  click_button 'Submit'
end 

Then("I should see the changes in the event") do
  expect(page).to have_content @event.title
  expect(page).to have_content 'Changed Description'
end

Then('I should see a delete button') do
  expect(page).to have_link('Delete', href: event_path(@event))
end

When("I click the delete button") do
  find_link('Delete',href: event_path(@event)).click
end

# Then("I should get an alert") do
#   selenium.is_alert_present.should be_true
# end

# When("I click okay") do
#   pending # Write code here that turns the phrase above into concrete actions
# end

Then("I should see that the event has been deleted") do
  expect(page).to have_no_content @event.title
  expect(page).to have_no_content @event.description
end
