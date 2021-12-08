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
    confirmed_at { 1.day.ago }
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

  factory :tag do
    name {'Accomodation'}
    email {'accomodation@ait.ac.th'}
  end

  factory :event, class: Event do
    title {'Talk show'}
    description {'Talk show of SU'}
    event_date {'2022/12/5'}
    association :tag, factory: :tag
  end

  factory :event1, class: Event do
    title {'First test'}
    description {'First test'}
    event_date {'2021/12/5'}
    association :tag, factory: :tag
  end

  factory :event2, class: Event do
    title {'Second test'}
    description {'Second test'}
    event_date {'2021/12/5'}
    association :tag, factory: :tag
  end

  factory :event3, class: Event do
    title {'Third test'}
    description {'Third test'}
    event_date {'2021/12/5'}
    association :tag, factory: :tag
  end

  factory :committee, class: Tag do
    name { 'Accommodation' }
    email { 'test@help.com' }
  end
end
