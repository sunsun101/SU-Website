FactoryBot.define do
  factory :quotation do
    author_name { 'Test Author' }
    category { 'Humour' }
    quote { 'Best is yet to come' }
  end

  factory :admin, class: User do
    email { 'joe_admin@ait.asia' }
    password { 'password' }
    password_confirmation { 'password' }
    is_admin { true }
    status { 'A' }
  end

  factory :user, class: User do
    email { 'joe_user@ait.asia' }
    password { 'password' }
    password_confirmation { 'password' }
    is_admin { false }
    status { 'A' }
  end

  factory :su_member, class: SuMember do
    first_name { 'Test' }
    last_name { 'test' }
    designation { 'President' }
    nationality { 'Nepal' }
    department { 'SET' }
    program {'CS'}
  end
end
