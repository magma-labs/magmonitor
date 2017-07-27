# frozen_string_literal: true

FactoryGirl.define do
  factory :invite do
    email FFaker::Internet.email
  end
end
