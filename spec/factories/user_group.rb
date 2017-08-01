# frozen_string_literal: true

FactoryGirl.define do
  factory :user_group do
    name FFaker::Company.name
  end
end
