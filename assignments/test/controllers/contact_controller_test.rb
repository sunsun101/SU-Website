require "test_helper"

class ContactControllerTest < ActionDispatch::IntegrationTest
  test "should get form" do
    get contact_form_url
    assert_response :success
  end
end
