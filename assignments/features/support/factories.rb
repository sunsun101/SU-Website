FactoryBot.define do
  factory :quotation, class: Quotation do
    author_name { "Test Author" }
    category { "Humour" }
    quote { "Best is yet to come" }
  end
end
