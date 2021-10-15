FactoryBot.define do
  factory :quotation do
    author_name { 'Test Author' }
    category { 'Humour' }
    quote { 'Best is yet to come' }
  end

  factory :admin, class: User do
    email { 'joe_admin@ait' }
    password { 'password' }
    password_confirmation { 'password' }
    is_admin? { true }
  end

  factory :user, class: User do
    email { 'joe_user@ait' }
    password { 'password' }
    password_confirmation { 'password' }
    is_admin? { false }
  end
end
