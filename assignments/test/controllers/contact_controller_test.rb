require 'test_helper'

class ContactControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test 'should get contact form' do
    sign_in users(:one)
    get contact_form_url
    assert_response :success
  end
end
