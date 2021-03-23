FactoryBot.define do
  factory :record do
    date { "2021-3-20" }
    data { 200 }
    unit_id { 2 }
    inpression { "テキスト" }
    objective_id { "1" }

    association :user
    association :objective

  end
end
