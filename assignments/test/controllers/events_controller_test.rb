require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get events_url
    assert_response :success
  end

  test 'should get filered events' do
    get events_url, params: {tag_id: 1}
    assert_response :success
  end

  test 'display event form' do
    get new_event_url
    assert_response :success
  end

  test 'create events' do
    assert_difference('Event.count') do
      post events_path,
           params: { event: {title: @event.title, description: @event.description, event_date: @event.event_date, pictures: [fixture_file_upload("test.png","image/png"),fixture_file_upload("test.png","image/png")] } }
    end
  end

  test 'event creation failure' do
    post events_path,
           params: { event: { description: @event.description, event_date: @event.event_date, pictures: [fixture_file_upload("test.png","image/png"),fixture_file_upload("test.png","image/png")] } }
  end

  test 'view past events' do
    get past_events_url
    assert_response :success
  end

  test 'filter past_events' do
    get past_events_url, params: { date: {month: 11} }
  end

  test 'update event' do
    put event_url(@event), params: { event: {title: @event.title, description: @event.description, event_date: @event.event_date, pictures: [fixture_file_upload("test.png","image/png"),fixture_file_upload("test.png","image/png")] } }
  end

  test 'update event failure' do
    put event_url(@event), params: { event: {title: nil, description: @event.description, event_date: @event.event_date, pictures: [fixture_file_upload("test.png","image/png"),fixture_file_upload("test.png","image/png")] } }
  end

  test 'storing of path in session' do
    get event_path(@event)
  end

  test 'deletion of event' do
    delete event_url(@event)
  end

  test 'deletion of image' do
    p fixture_file_upload("test.png","image/png")
    post events_removeImage_path, params: {id: fixture_file_upload("test.png","image/png") }
  end
end
