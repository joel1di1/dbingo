# frozen_string_literal: true

FactoryBot.define do
  factory :meeting_member do
    user
    meeting
  end
end
