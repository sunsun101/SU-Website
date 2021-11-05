require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test 'sign up navigation' do
    get new_user_registration_path
    assert_response :success
    assert_difference('User.count', 1) do
      post user_registration_path,
           params: { user: { email: 'id@ait.asia', password: 'password', password_confirmation: 'password' } }
    end
  end
end
