# frozen_string_literal: true

FactoryGirl.define do
  factory :organization do
    name FFaker::Company.name
    contact_email FFaker::Internet.email
  end
end
