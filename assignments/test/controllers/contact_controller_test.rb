require 'test_helper'

class ContactControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @admin = users(:one)
    @user = users(:two)
    @tag = tags(:one)
    @complain = complains(:one)
  end
  test 'should get contact form' do
    sign_in users(:one)
    get contact_form_url
    assert_response :success
  end

  test 'create complain' do
    sign_in users(:one)
    assert_difference('Complain.count') do
      post contact_form_url, params: { complain: { user_id: @user.id,
                                                   tag_id: @tag.id, detail: @complain.id, status: 'New', subject: 'Big rats bro' } }
    end
  end

  test 'error create complain' do
    sign_in users(:one)
    post contact_form_url, params: { complain: { user_id: @user.id,
                                                 tag_id: '', detail: @complain.id, status: 'New', subject: 'Big rats bro' } }
  end
end
