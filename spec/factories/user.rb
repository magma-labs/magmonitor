# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    name 'Magmonitor User'
    email FFaker::Internet.email
    password FFaker::Internet.password
    fully_registered true
    organizations [FactoryGirl.create(:organization, name: 'MagmaLabs')]
  end
end
