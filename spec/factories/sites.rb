# frozen_string_literal: true

FactoryGirl.define do
  factory :site do
    name FFaker::Venue.name
    association :organization
  end
end
