require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get events_url
    assert_response :success
  end

  test 'create events' do
    assert_difference('Event.count') do
      post events_path,
           params: { event: {title: @event.title, description: @event.description, event_date: @event.event_date } }
    end
  end
end
