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

  test 'sql query returns data' do
    data = User.find_by_sql("SELECT
      date_trunc('day', created_at) AS created_date,
      count(id) as total_count
    FROM users
    WHERE date_part ('year', created_at) = date_part('year',current_date)
    GROUP BY created_date
    ORDER BY created_date, total_count")

    assert_equal(0, data.size)
  end
end
