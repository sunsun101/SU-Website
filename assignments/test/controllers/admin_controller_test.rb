require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @admin = users(:one)
    @user = users(:two)
    @tag = tags(:one)
    @complain = complains(:one)
  end

  test 'should get users' do
    sign_in users(:one)
    get admin_users_url
    assert_response :success
  end

  test 'should appoint committee' do
    sign_in users(:one)
    get admin_users_url, params: { user: { id: @user.id, tag_id: '1' } }
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
  test 'should advance search for complains' do
    sign_in @admin
    get admin_feedback_path,
        params: { adsearch: true, status: '', tag_id: '', date_from: '2021-10-20',
                  date_to: '2021-10-21' }
  end

  test 'should advance search for complains 2' do
    sign_in @admin
    @admin.tag_id = '1'
    get admin_feedback_path,
        params: { adsearch: true, status: '', tag_id: '', date_from: '2021-10-20',
                  date_to: '2021-10-21' }
  end

  test 'should get committee page' do
    sign_in users(:one)
    get admin_committee_url
    assert_response :success
  end

  test 'create committee' do
    sign_in users(:one)
    assert_difference('Tag.count') do
      post admin_committee_path, params: { tag: { name: @tag.name, email: @tag.email } }
    end
  end

  test 'error create committee' do
    sign_in users(:one)
    post admin_committee_path, params: { tag: { name: '', email: @tag.email } }
  end

  test 'update committee' do
    sign_in users(:one)
    patch admin_committee_path, params: { tag: { id: @tag.id, name: @tag.name, email: @tag.email } }
  end

  test 'error update committee' do
    sign_in users(:one)
    patch admin_committee_path, params: { tag: { id: @tag.id, name: '', email: @tag.email } }
  end

  test 'delete committee' do
    sign_in users(:one)
    delete admin_committee_path, params: { tag: { id: @tag.id } }
  end

  test 'should get feedback page' do
    sign_in users(:one)
    get admin_feedback_url
    assert_response :success
  end

  test 'update feedback' do
    sign_in @admin
    @complain = complains(:one)
    patch admin_feedback_path,
          params: { complain: { id: @complain.id, updatedBy: @admin.email, status: 'Completed' } }
  end

  test 'delete feedback' do
    sign_in users(:one)
    delete admin_feedback_path, params: { complain: { id: @complain.id } }
  end
end
