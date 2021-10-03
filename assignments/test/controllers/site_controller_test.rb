require 'test_helper'

class SiteControllerTest < ActionDispatch::IntegrationTest
  test 'should get site index' do
    get root_url
    assert_response :success
  end
end
