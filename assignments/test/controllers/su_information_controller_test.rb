require "test_helper"

class SuInformationControllerTest < ActionDispatch::IntegrationTest
  setup do
    @su_member = su_members(:one)
  end

  test "should get index" do
    get su_information_url
    assert_response :success
  end
  test "create su member" do
    assert_difference("SuMember.count") do
      post su_information_path, params: { su_member: { first_name: @su_member.first_name, last_name: @su_member.last_name, designation: @su_member.designation, nationalitiy: @su_member.nationality, department: @su_member.department, program: @su_member.program } }
    end
  end
end
