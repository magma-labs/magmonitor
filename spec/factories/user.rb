# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    name 'Magmonitor User'
    email 'magmonitor_user@magmonitor.com'
    password FFaker::Internet.password
    fully_registered true
    organizations [FactoryGirl.create(:organization, name: 'MagmaLabs')]
  end
end
