FactoryBot.define do
  factory :country do
    sequence(:name) { |n| "Country #{n}" }
    sequence(:alpha_code_2, ('AA'..'ZZ').cycle)
    sequence(:alpha_code_3, ('AAA'..'AZZ').cycle)
    sequence(:currency_code, ('CAA'..'CZZ').cycle)
  end
end
