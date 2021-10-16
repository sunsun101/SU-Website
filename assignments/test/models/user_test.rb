require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'first user should become admin' do
    User.all.each(&:destroy)
    user = User.create email: 'joe_admin@why.com', password: 'password', created_at: '2020-09-09 07:01:51.461869'
    assert user.is_admin, user.errors.full_messages
  end
end
