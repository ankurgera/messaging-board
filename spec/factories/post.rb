# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    association :user, factory: :user

    title { Faker::String.random }
    body { Faker::String.random }
  end
end
