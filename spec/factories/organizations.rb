# frozen_string_literal: true

FactoryGirl.define do
  factory :organization do
    name FFaker::Company.name
    contact_email FFaker::Internet.email

    initialize_with { Organization.find_or_create_by(name: name) }
  end
end
