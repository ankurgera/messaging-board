# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    association :user, factory: :user
    association :post, factory: :post

    body { Faker::String.random }
  end
end
