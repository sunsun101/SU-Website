require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @admin = users(:one)
    @user = users(:two)
  end

  test 'should get users' do
    sign_in users(:one)
    get admin_users_url
    assert_response :success
  end

  test 'should ban user' do
    sign_in users(:one)
    patch admin_users_path, params: { user: { status: 'Active', id: @user.id } }
  end
  test 'should un-ban user' do
    sign_in users(:one)
    patch admin_users_path, params: { user: { status: 'Ban', id: @user.id } }
  end

  test 'should give user admin priviledge' do
    sign_in users(:one)
    patch admin_users_path, params: { user: { is_admin: '1', id: @user.id } }
  end

  test 'should remove user admin priviledge' do
    sign_in users(:one)
    patch admin_users_path, params: { user: { is_admin: '0', id: @user.id } }
  end

  test 'should advance search' do
    sign_in users(:one)
    get admin_users_path,
        params: { adsearch: true, user_status: 'Active', admin: 'Admin', date_from: '2021-10-20',
                  date_to: '2021-10-21' }
  end
  test 'should advance search 2' do
    sign_in users(:one)
    get admin_users_path,
        params: { adsearch: true, user_status: 'Banned', admin: 'Members', date_from: '2021-10-20',
                  date_to: '2021-10-21' }
  end
end
