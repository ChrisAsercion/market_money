FactoryBot.define do
  factory :market do
    name { "#{Faker::Company.industry}" }
    street { Faker::Address.street_name }
    city { Faker::JapaneseMedia::OnePiece.location  }
    county { Faker::Address.community }
    state { Faker::JapaneseMedia::OnePiece.island}
    zip { Faker::Address.zip_code.slice(0, 5) }
    lat { Faker::Address.latitude.round(5) }
    lon { Faker::Address.longitude.round(5) }
  end
end