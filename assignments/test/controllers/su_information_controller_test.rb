require 'test_helper'

class SuInformationControllerTest < ActionDispatch::IntegrationTest
  setup do
    @su_member = su_members(:one)
  end

  test 'should get index' do
    get su_information_url
    assert_response :success
  end

  test 'should get member of a specific committee' do
    get su_information_url, params: { su_members: { tagy: @su_member.tag_id } }
  end
  test 'create su member' do
    assert_difference('SuMember.count') do
      post su_information_path,
           params: { su_member: { first_name: @su_member.first_name, last_name: @su_member.last_name,
                                  designation: @su_member.designation, nationality: @su_member.nationality, tag_id: @su_member.tag_id, department: @su_member.department, program: @su_member.program, crop_x: '0', crop_y: '0', crop_width: '0', crop_height: '0' } }
    end
  end
  test 'error in su member creation' do
    post su_information_path,
         params: { su_member: { first_name: @su_member.first_name, last_name: @su_member.last_name,
                                designation: @su_member.designation, nationality: @su_member.nationality, department: @su_member.department } }
  end

  test 'edit su member' do
    patch su_information_path,
          params: { su_member: { id: @su_member.id, first_name: @su_member.first_name, last_name: @su_member.last_name,
                                 designation: @su_member.designation, nationality: @su_member.nationality, department: @su_member.department, program: @su_member.program } }
  end
  test 'error in su member updating' do
    patch su_information_path,
          params: { su_member: { id: @su_member.id, first_name: '', last_name: @su_member.last_name,
                                 designation: @su_member.designation, nationality: @su_member.nationality, department: @su_member.department } }
  end

  test 'Delete su member' do
    delete su_information_path,
           params: { su_member: { id: @su_member.id } }
  end
end
