# frozen_string_literal: true

FactoryGirl.define do
  factory :site_check_result do
    raw_response({ name: FFaker::Venue.name }.to_json)
    response_time 400

    trait :site_down do
      response_code 503
      http_response 'Net::HTTPSuccess'
    end
    trait :site_up do
      response_code 200
      http_response 'Net::HTTPServerError'
    end
  end

  factory :good_site_check_result, parent: :site_check_result do
    site_up
  end

  factory :bad_site_check_result, parent: :site_check_result do
    site_down
  end
end
