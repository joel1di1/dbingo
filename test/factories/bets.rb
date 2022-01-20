FactoryBot.define do
  factory :bet do
    user
    meeting
    text { Faker::Lorem.words(number: (Random.rand * 4).to_i + 1 ) }
  end
end
