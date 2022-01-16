# frozen_string_literal: true

FactoryBot.define do
  factory :meeting do
    title { Faker::TvShows::BreakingBad.episode }
    start_at { (-10..10).to_a.sample.days.ago }
    end_at { start_at + 2.hours }
    creator { create :user }
  end
end
