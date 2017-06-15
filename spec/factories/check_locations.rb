# frozen_string_literal: true

FactoryGirl.define do
  factory :check_location do
    name 'America'

    trait :mexico do
      name 'Mexico'
    end
  end
end
