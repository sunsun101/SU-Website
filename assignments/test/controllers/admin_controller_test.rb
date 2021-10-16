require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:one)
    @user = users(:two)
  end
  test 'should get users' do
    get admin_users_url
    assert_response :success
  end
  test 'should ban user' do
    get admin_users_path, params: { user_ban: @user.id }
  end
  test 'should un-ban user' do
    get admin_users_path, params: { user_unban: @user.id }
  end
end
