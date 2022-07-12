FactoryBot.define do
  factory :item do
    name { Faker::JapaneseMedia::SwordArtOnline.item }
    description { Faker::TvShows::MichaelScott.quote }
    unit_price { Faker::Number.within(range: 1..100) }
  end
end
