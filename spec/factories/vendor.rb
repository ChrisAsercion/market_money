FactoryBot.define do
  factory :vendor do
    name { Faker::Company.name }
    description { Faker::Books::Dune.saying }
    contact_name { Faker::JapaneseMedia::OnePiece.character  }
    contact_phone { Faker::PhoneNumber.phone_number }
    credit_accepted { Faker::Boolean.boolean(true_ratio: 0.9)}
  end
end